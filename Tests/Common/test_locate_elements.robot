*** Settings ***

Resource  	../../Resources/PageObject/KeyDefs/Common.robot
Resource  	../../Resources/PageObject/KeyDefs/SeleniumDrivers.robot
Variables 	../../Resources/PageObject/Locators/Locators.py

# Test Teardown  Common.Close local test browser

Library    	BuiltIn
Library		OperatingSystem

*** Variables ***

${site_url}  		https://lambdatest.github.io/sample-todo-app/

*** Comments ***
# Configuration for first test scenario

*** Variables ***
${EXEC_PLATFORM}  %{EXEC_PLATFORM}

&{lt_options_local_1}
    ...  browserName=Chrome

${BROWSER_LOCAL_1}	  	  ${lt_options_local_1['browserName']}

*** Comments ***
# Configuration for second test scenario

*** Variables ***

&{lt_options_local_2}
    ...  browserName=Edge

${BROWSER_LOCAL_2}	  	  ${lt_options_local_2['browserName']}

&{lt_options_local_3}
    ...  browserName=Firefox

${BROWSER_LOCAL_3}	  	  ${lt_options_local_3['browserName']}

*** Variables ***

&{lt_options_cloud_1}
    ...  browserName=Chrome
    ...  platformName=Windows 11
    ...  browserVersion=latest
    ...  visual=true
    ...	 w3c=true
	...  console=true
    ...	 geoLocation=US
    ...  name=[ToDoApp - 1] ToDoApp with Robot framework
    ...  build=[ToDoApp Demo - 1] ToDoApp with Robot framework
    ...  project=[ToDoApp Project - 1] ToDoApp with Robot framework

${BROWSER_CLOUD_1}	      ${lt_options_cloud_1['browserName']}
&{CAPABILITIES_CLOUD_1}     LT:Options=&{lt_options_cloud_1}

*** Comments ***
# Configuration for second test scenario

*** Variables ***

&{lt_options_cloud_2}
    ...  browserName=Firefox
    ...  platformName=Windows 11
    ...  browserVersion=latest
    ...  visual=true
    ...	 w3c=true
	...  console=true
    ...	 geoLocation=US
    ...  name=[ToDoApp - 2] ToDoApp with Robot framework
    ...  build=[ToDoApp Demo - 2] ToDoApp with Robot framework
    ...  project=[ToDoApp Project - 2] ToDoApp with Robot framework

${BROWSER_CLOUD_2}	      ${lt_options_cloud_2['browserName']}
&{CAPABILITIES_CLOUD_2}     LT:Options=&{lt_options_cloud_2}

&{lt_options_cloud_3}
    ...  browserName=Chrome
    ...  platformName=Windows 10
    ...  browserVersion=latest-2
    ...  visual=true
    ...	 w3c=true
	...  console=true
    ...	 geoLocation=US
    ...  name=[ToDoApp - 3] ToDoApp with Robot framework
    ...  build=[ToDoApp Demo - 3] ToDoApp with Robot framework
    ...  project=[ToDoApp Project - 3] ToDoApp with Robot framework

${BROWSER_CLOUD_3}	      ${lt_options_cloud_3['browserName']}
&{CAPABILITIES_CLOUD_3}     LT:Options=&{lt_options_cloud_3}

*** Keywords ***

Test Teardown
	IF  '${EXEC_PLATFORM}' == 'local'
        Log To Console	Closing the browser on local machine
        Common.Close local test browser
    ELSE IF 	'${EXEC_PLATFORM}' == 'cloud'
        Log To Console	Closing the browser on cloud grid
		Common.Close test browser
    END

*** Test Cases ***

Example 1: [ToDo] Demo with Robot framework
	[tags]  ToDo App Automation - 1
	[Timeout]   ${TIMEOUT}
	# Get Environment Variables
	Log To Console		Tests executed on: ${EXEC_PLATFORM}
	IF  '${EXEC_PLATFORM}' == 'local'
		${chrome_driver_path}=    Update Chrome Webdriver
		# Open Browser    ${site_url}    chrome    executable_path=${chrome_driver_path}
		Open local test browser 	${site_url}		${BROWSER_LOCAL_1}	${chrome_driver_path}
	ELSE
		# [ WARN ] desired_capabilities has been deprecated and removed.
        # Please use options to configure browsers as per documentation.
		# Open test browser	${site_url}		${BROWSER_CLOUD_1}		${CAPABILITIES_CLOUD_1}
		Open test browser	${site_url}		${BROWSER_CLOUD_1}		${lt_options_cloud_1}
	END
	Maximize Browser Window
	Sleep  3s
	Page should contain element  ${FirstItem}
	Page should contain element  ${SecondItem}

	Click button  ${FirstItem}	
	Click button  ${SecondItem}	
		
	Input text  ${ToDoText}  ${NewItemText}
	Click button  ${AddButton}
	${response}    Get Text    ${NewAdditionText}
	Should Be Equal As Strings    ${response}    ${NewItemText}
	Sleep  5s
        Log    Completed - Example 1: [ToDo] Parallel Testing with Robot framework
	[Teardown]  Test Teardown

Example 2: [ToDo] Demo with Robot framework
	[tags]  ToDo App Automation - 2
	[Timeout]   ${TIMEOUT}
	# Get Environment Variables
	Log To Console		Tests executed on: ${EXEC_PLATFORM}
	IF  '${EXEC_PLATFORM}' == 'local'
		${edge_driver_path}=   Update Edge Webdriver
		# Open Browser    ${site_url}    edge	executable_path=${edge_driver_path}
		Open local test browser 	${site_url}		${BROWSER_LOCAL_2}	${edge_driver_path}
	ELSE IF  '${EXEC_PLATFORM}' == 'cloud'
		# [ WARN ] desired_capabilities has been deprecated and removed.
        # Please use options to configure browsers as per documentation.
		# Open test browser	${site_url}		${BROWSER_CLOUD_2}		${CAPABILITIES_CLOUD_2}
		Open test browser	${site_url}		${BROWSER_CLOUD_2}		${lt_options_cloud_2}
	END
	Maximize Browser Window
	Sleep  3s
	Page should contain element  ${FirstItem}
	Page should contain element  ${SecondItem}
	Page should contain element  ${FifthItem}

	Click button  ${FirstItem}	
	Click button  ${SecondItem}
	Click button  ${FifthItem}	
		
	Input text  ${ToDoText}  ${NewItemText}
	Click button  ${AddButton}
	${response}    Get Text    ${NewAdditionText}
	Should Be Equal As Strings    ${response}    ${NewItemText}
	Sleep  5s
        Log    Completed - Example 2: [ToDo] Parallel Testing with Robot framework
	[Teardown]  Test Teardown

Example 3: [ToDo] Demo with Robot framework
	[tags]  ToDo App Automation - 3
	[Timeout]   ${TIMEOUT}
	# Get Environment Variables
	Log To Console		Tests executed on: ${EXEC_PLATFORM}
	IF  '${EXEC_PLATFORM}' == 'local'
		${firefox_driver_path}=   Update Firefox Webdriver
		# Open Browser    ${site_url}    edge	executable_path=${edge_driver_path}
		Open local test browser 	${site_url}		${BROWSER_LOCAL_3}	${firefox_driver_path}
	ELSE IF  '${EXEC_PLATFORM}' == 'cloud'
		# [ WARN ] desired_capabilities has been deprecated and removed.
        # Please use options to configure browsers as per documentation.
		# Open test browser	${site_url}		${BROWSER_CLOUD_3}		${CAPABILITIES_CLOUD_3}
		Open test browser	${site_url}		${BROWSER_CLOUD_3}		${lt_options_cloud_3}
	END
	Maximize Browser Window
	Sleep  3s
	Page should contain element  ${FirstItem}
	Page should contain element  ${SecondItem}
	Page should contain element  ${FifthItem}

	Click button  ${FirstItem}	
	Click button  ${SecondItem}
	Click button  ${FifthItem}	
		
	Input text  ${ToDoText}  ${NewItemText}
	Click button  ${AddButton}
	${response}    Get Text    ${NewAdditionText}
	Should Be Equal As Strings    ${response}    ${NewItemText}
	Sleep  5s
        Log    Completed - Example 3: [ToDo] Parallel Testing with Robot framework
	[Teardown]  Test Teardown