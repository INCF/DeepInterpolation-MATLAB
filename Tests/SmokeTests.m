classdef SmokeTests < matlab.unittest.TestCase
    
    properties (TestParameter)
        DemoFile = struct( ... 
			'DeepInterpolation', {@DeepInterpolation});
        Shortcut = struct( ... 
			'openDeepInterpolation', {@openDeepInterpolation});
    end    
    
    methods (TestClassSetup)
        
        % Shut off graphics warnings
        function killGraphicsWarning(testCase)
            ws = warning('off', 'MATLAB:hg:AutoSoftwareOpenGL');
            testCase.addTeardown(@()warning(ws));
            
        end
        
        % Close any new figures created by doc
        function saveExistingFigures(testCase)            
            existingfigs = findall(groot, 'Type', 'Figure');
            testCase.addTeardown(@()delete(setdiff(findall(groot, 'Type', 'Figure'), existingfigs)))
            
        end
        
    end
    
    methods (Test)
        
        function demoShouldNotWarn(testCase, DemoFile)       
            import matlab.unittest.fixtures.SuppressedWarningsFixture
            importwarnings = ["nnet_cnn_kerasimporter:keras_importer:UnsupportedLoss"; 
                "nnet_cnn_kerasimporter:keras_importer:UnsupportedOutputLayerWarning"];
            okwarnings = SuppressedWarningsFixture(importwarnings);
            testCase.applyFixture(okwarnings)
            testCase.verifyWarningFree(DemoFile);
            
        end
        
        
        function shortcutShouldNotWarn(testCase, Shortcut)
            testCase.verifyWarningFree(Shortcut);
            
        end
        
    end

end
