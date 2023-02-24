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
                functionName = parseFunctionName(obj, i);
                complexityValue = parseComplexityValue(obj, i);

                obj.CodeComplexity = [obj.CodeComplexity; table(functionName, complexityValue)];
            end
            if height(obj.CodeComplexity) > 0
                obj.CodeComplexity.Properties.VariableNames = {'FunctionName', 'CyclomaticComplexity'};
            end
        end
        function functionName = parseFunctionName(obj, index)
            functionName = string(extractBetween(obj.LinterInformation(index).message, "'", "'"));
            if isempty(functionName)
                functionName = string(extractBetween(obj.LinterInformation(index).message, '"', '"'));
            end
            if isempty(functionName)
                functionName = strcat("Unparsable name (at line ", num2str(obj.LinterInformation(index).line), ")");
            end
        end
        function complexityValue = parseComplexityValue(obj, index)
            words = split(obj.LinterInformation(index).message);
            complexityValue = str2double(replace(words(end), '.', ''));
        end
    end
end
