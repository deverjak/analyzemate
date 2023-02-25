classdef File
    
    properties
        Filename (1,1) string 
        Filepath (1,1) string 
        FileType (1,1) analyzemate.staticanalysis.FileType
        ChangeCount = 0
        Cohesion = 0
        LengthOfFile = 0
        CyclomaticComplexity table
        FunctionLength table
    end
    
end

