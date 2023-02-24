classdef CyclomaticComplexityCalculatorTest < matlab.unittest.TestCase 

    properties (Access = private)
        Linter
    end

    methods (TestMethodSetup)
        function setupLinter(testCase)
            stubICodeLinterInterface = doubles.ICodeLinterStub();
            testCase.Linter = ...
                analyzemate.staticanalysis.CyclomaticComplexityCalculator(...
                stubICodeLinterInterface);
        end
    end

    methods(Test)
        function checkCodeComplexityOfSimpleFunction_shouldBeOne(testCase)
            testCase.Linter.analyze('oneitemstruct');
            testCase.verifyEqual(testCase.Linter.CodeComplexity(1,1).Variables, "testFun");
            testCase.verifyEqual(testCase.Linter.CodeComplexity(1,2).Variables, 1);
        end
        function checkCodeComplexityOfComplexerFunction_shouldBeTwo(testCase)
            testCase.Linter.analyze('twoitemstruct');
            testCase.verifyEqual(testCase.Linter.CodeComplexity(1,1).Variables, "testBar");
            testCase.verifyEqual(testCase.Linter.CodeComplexity(1,2).Variables, 2);
        end
        function checkCodeComplexityOfClass_shouldGetThreeAndFive(testCase)
            testCase.Linter.analyze('classlikestruct');
            testCase.verifyEqual(testCase.Linter.CodeComplexity.FunctionName, ...
                ["testFun"; "testFoo"]);
            testCase.verifyEqual(testCase.Linter.CodeComplexity.CyclomaticComplexity, [3; 5]);
        end
        function checkCodeComplexityOfSimpleFunctionWithinQuotes_shouldBeOne(testCase)
            testCase.Linter.analyze('oneitemstructwithinquotes');
            testCase.verifyEqual(testCase.Linter.CodeComplexity(1,1).Variables, "testFun");
            testCase.verifyEqual(testCase.Linter.CodeComplexity(1,2).Variables, 1);
        end
        function checkCodeComplexityOfFunctionWithUnparsableName_shouldBeOne(testCase)
            testCase.Linter.analyze('structwithunparsablename');
            testCase.verifyEqual(testCase.Linter.CodeComplexity(1,1).Variables, "Unparsable name (at line 1)");
            testCase.verifyEqual(testCase.Linter.CodeComplexity(1,2).Variables, 1);
        end
    end 
end