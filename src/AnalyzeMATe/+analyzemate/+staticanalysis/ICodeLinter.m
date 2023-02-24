classdef (Abstract) ICodeLinter < handle
    
    methods (Abstract)
        analyze(obj, file)
    end
end

