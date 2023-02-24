classdef ICodeLinterStub < analyzemate.staticanalysis.ICodeLinter

    properties (Access = private)
        StubStruct
    end

    methods (Access = public)
        function informStruct = anylyzeCode(obj, file)
            if isequal(file, 'oneitemstruct')
                obj.createStubStructureWithOneItem();
            elseif isequal(file, 'oneitemstructwithinquotes')
                obj.createStubStructureWithOneItemWithinQuotes();
            elseif isequal(file, 'twoitemstruct')
                obj.createStubStructureWithTwoItems();
            elseif isequal(file, 'classlikestruct')
                obj.createStubStructureWithTWoFunctionsLikeClass();
            else 
                obj.createStubStructureWithOneAnonymousFunction();
            end

            informStruct = obj.StubStruct;
        end
    end

     methods(Access = private)
        function createStubStructureWithOneItem(obj)
            obj.StubStruct = struct('id', 'MCABE', 'message', ...
                'The modified cyclomatic complexity of ''testFun'' is 1.', ...
                'fix', 0,'line', [], 'column', []);
        end

        function createStubStructureWithOneItemWithinQuotes(obj)
            obj.StubStruct = struct('id', 'MCABE', 'message', ...
                'The modified cyclomatic complexity of "testFun" is 1.', ...
                'fix', 0,'line', [], 'column', []);
        end
        
        function createStubStructureWithOneAnonymousFunction(obj)
            obj.StubStruct = struct('id', 'MCABE', 'message', ...
                'The modified cyclomatic complexity of anonymous function is 1.', ...
                'fix', 0,'line', 1, 'column', []);
        end
            
        function createStubStructureWithTwoItems(obj)
            obj.StubStruct = struct('id', 'MCABE', 'message', ...
                'The modified cyclomatic complexity of ''testBar'' is 2.', ...
                'fix', 0,'line', [], 'column', []);
            obj.StubStruct(2) = struct('id', 'ANY', 'message', ...
                'Dummy Message Text', ...
                'fix', 0,'line', [], 'column', []);
        end

        function createStubStructureWithTWoFunctionsLikeClass(obj)
            obj.StubStruct = struct('id', 'MCABE', 'message', ...
                'The modified cyclomatic complexity of ''testFun'' is 3.', ...
                'fix', 0,'line', [], 'column', []);
            obj.StubStruct(2) = struct('id', 'ANY', 'message', ...
                'Dummy Message Text', ...
                'fix', 0,'line', [], 'column', []);
            obj.StubStruct(3) = struct('id', 'MCABE', 'message', ...
                'The modified cyclomatic complexity of ''testFoo'' is 5.', ...
                'fix', 0,'line', [], 'column', []);
        end
    end
end

