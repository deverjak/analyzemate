classdef MatlabLinter < analyzemate.staticanalysis.ICodeLinter
    
    properties (Access = private)
        
    end

    methods (Access = public)
        function informStruct = anylyzeCode(~, file)
            informStruct = checkcode(file, '-modcyc', ...
                '-fullpath', '-id');
        end
    end
end
