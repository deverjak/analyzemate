classdef IFileInterfaceStub < analyzemate.general.IFileInterface
    
    methods        
        function textfile = readFileAsString(obj, file)
            textfile = readlines(file);
        end
    end
end
