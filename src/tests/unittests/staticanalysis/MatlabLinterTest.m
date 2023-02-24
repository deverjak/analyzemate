classdef MatlabLinterTest < matlab.unittest.TestCase & ...
        analyzemate.staticanalysis.MatlabLinter

    methods(Test)
        function checkCodeComplexityOfSimpleFunction_shouldBeOne(testCase)
            testCase.analyze('oneitemstruct');
            testCase.verifyEqual(testCase.CodeComplexity(1,1).Variables, "testFun");
            testCase.verifyEqual(testCase.CodeComplexity(1,2).Variables, 1);
        end
        function checkCodeComplexityOfComplexerFunction_shouldBeTwo(testCase)
            testCase.analyze('twoitemstruct');
            testCase.verifyEqual(testCase.CodeComplexity(1,1).Variables, "testBar");
            testCase.verifyEqual(testCase.CodeComplexity(1,2).Variables, 2);
        end
        function checkCodeComplexityOfClass_shouldGetThreeAndFive(testCase)
            testCase.analyze('classlikestruct');
            testCase.verifyEqual(testCase.CodeComplexity.FunctionName, ...
                ["testFun"; "testFoo"]);
            testCase.verifyEqual(testCase.CodeComplexity.CyclomaticComplexity, [3; 5]);
        end
    end

    methods (Access = protected)
        function runStaticAnalysis(testCase, file)
            if isequal(file, 'oneitemstruct')
                testCase.createStubStructureWithOneItem();
            elseif isequal(file, 'twoitemstruct')
                testCase.createStubStructureWithTwoItems();
            else
                testCase.createStubStructureWithTWoFunctionsLikeClass();
            end
        end
    end

    methods(Access = private)
        function createStubStructureWithOneItem(testCase)
            testCase.LinterInformation = struct('id', 'MCABE', 'message', ...
                'The modified cyclomatic complexity of ''testFun'' is 1.', ...
                'fix', 0,'line', [], 'column', []);
        end

        function createStubStructureWithTwoItems(testCase)
            testCase.LinterInformation = struct('id', 'MCABE', 'message', ...
                'The modified cyclomatic complexity of ''testBar'' is 2.', ...
                'fix', 0,'line', [], 'column', []);
            testCase.LinterInformation(2) = struct('id', 'ANY', 'message', ...
                'Dummy Message Text', ...
                'fix', 0,'line', [], 'column', []);
        end

        function createStubStructureWithTWoFunctionsLikeClass(testCase)
            testCase.LinterInformation = struct('id', 'MCABE', 'message', ...
                'The modified cyclomatic complexity of ''testFun'' is 3.', ...
                'fix', 0,'line', [], 'column', []);
            testCase.LinterInformation(2) = struct('id', 'ANY', 'message', ...
                'Dummy Message Text', ...
                'fix', 0,'line', [], 'column', []);
            testCase.LinterInformation(3) = struct('id', 'MCABE', 'message', ...
                'The modified cyclomatic complexity of ''testFoo'' is 5.', ...
                'fix', 0,'line', [], 'column', []);
        end
    end

end