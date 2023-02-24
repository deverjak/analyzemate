import matlab.unittest.plugins.CodeCoveragePlugin
import matlab.unittest.plugins.codecoverage.CoverageReport

suite = testsuite("staticanalysis");
runner = testrunner("textoutput");

sourceCodeFolder = "src\AnalyzeMATe";
reportFolder = "coverageReport";
reportFormat = CoverageReport(reportFolder);
p = CodeCoveragePlugin.forFolder(sourceCodeFolder,"Producing",reportFormat);
runner.addPlugin(p)

results = runner.run(suite);