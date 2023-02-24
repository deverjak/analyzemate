classdef MatlabLinter < analyzemate.staticanalysis.ICodeLinter

    properties
        LinterInformation struct 
        CodeComplexity table
    end

    methods (Access = public)
        function analyze(obj, file)
            obj.runStaticAnalysis(file);
            obj.analyzeResult();
        end
    end
    methods (Access = protected)
        % Methods are protected for self-shunt unit testing
        function runStaticAnalysis(obj, file)
            obj.LinterInformation = checkcode(file, '-modcyc', ...
                '-fullpath', '-id');
        end
        function analyzeResult(obj)
            obj.filterInformationExceptCyclomaticComplexity();
            obj.parseCyclomaticComplexityFromMessages();
        end
        function filterInformationExceptCyclomaticComplexity(obj)
            isCyclomatic = ismember(string({obj.LinterInformation.id}), "MCABE");
            obj.LinterInformation(isCyclomatic == false) = [];
        end
        function parseCyclomaticComplexityFromMessages(obj)
            for i=1:length(obj.LinterInformation)
                functionName = string(extractBetween(obj.LinterInformation(i).message, "'", "'"));

                words = split(obj.LinterInformation(i).message);
                complexityValue = str2double(replace(words(end), '.', ''));
                obj.CodeComplexity = [obj.CodeComplexity; table(functionName, complexityValue)];
            end
            if height(obj.CodeComplexity) > 0
                obj.CodeComplexity.Properties.VariableNames = {'FunctionName', 'CyclomaticComplexity'};
            end
        end
    end
end
