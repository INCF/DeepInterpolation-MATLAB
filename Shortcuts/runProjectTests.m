function R = runProjectTests
% results = runProjectTests

    TS = matlab.unittest.TestSuite.fromProject(currentProject);
    R = run(TS);
    if ~nargout
        clearvars
    end

end