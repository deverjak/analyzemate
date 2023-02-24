classdef (Abstract) ICodeLinter < handle
    
    methods (Abstract)
        informStruct = anylyzeCode(obj, file)
    end
end

