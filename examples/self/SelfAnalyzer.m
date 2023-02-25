% Self analysis of the current repository
% Used for outside-in implementation of metric analysis

clc, clearvars
import analyzemate.staticanalysis.*
import analyzemate.filesystem.*

crawlerConfig = struct();
crawler = ProjectFilesCrawler(FileInterface(), crawlerConfig);

for path = crawler.getFilePaths()
    cyclCalculator = CyclomaticComplexityCalculator(MatlabLinter);
    cyclCalculator.analyze(path);

    disp(cyclCalculator.CodeComplexity);
end