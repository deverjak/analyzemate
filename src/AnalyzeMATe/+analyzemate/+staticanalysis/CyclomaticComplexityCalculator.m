classdef CyclomaticComplexityCalculator < handle
    %CYCLOMATICCOMPLEXITYCALCULATOR Summary of this class goes here
    %   Detailed explanation goes here

    properties (Access = private)
        CodeLinter (1,1) analyzemate.staticanalysis.ICodeLinter ...
            = analyzemate.staticanalysis.MatlabLinter
        LinterInformation struct
    end

    properties
        CodeComplexity table
    end

    methods
        function obj = CyclomaticComplexityCalculator(codeLinter)
            arguments
                codeLinter analyzemate.staticanalysis.ICodeLinter
            end
            obj.CodeLinter = codeLinter;
        end

        function analyze(obj, file)
            obj.runStaticAnalysis(file);
            obj.analyzeResult();
        end
    end

    methods (Access = private)
        % Methods are protect   ed for self-shunt unit testing
        function runStaticAnalysis(obj, file)
            obj.LinterInformation = obj.CodeLinter.anylyzeCode(file);
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

