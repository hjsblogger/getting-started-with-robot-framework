# Mimicking the tests mentioned in https://github.com/hjsblogger/
# selenium-automation-python-tutorial/blob/main/tests/pytest/10_mouse_interactions.py#L73

*** Settings ***

Resource  	../../Resources/PageObject/KeyDefs/Common.robot
Resource  	../../Resources/PageObject/KeyDefs/SeleniumDrivers.robot
Variables 	../../Resources/PageObject/Locators/Locators.py

Test Teardown  Common.Close local test browser

# https://robotframework.org/robotframework/latest/libraries/BuiltIn.html
Library    	BuiltIn
Library		Collections

*** Variables ***

${site_url_1}  		https://www.lambdatest.com/selenium-playground/drag-and-drop-demo
${site_url_2}  		https://ecommerce-playground.lambdatest.io/

*** Comments ***
# Configuration for first test scenario

*** Variables ***

${EXEC_PLATFORM}  %{EXEC_PLATFORM}

&{lt_local_options}
    ...  browserName=Chrome

${BROWSER_LOCAL}	  	  	${lt_local_options['browserName']}

&{lt_cloud_options}
    ...  browserName=Chrome
    ...  platformName=MacOS Monterey
    ...  browserVersion=latest-1
    ...  visual=true
    ...  console=true
    ...	 w3c=true
    ...	 geoLocation=US
    ...  name=[ECommerce Test - 1] Action Chains with Robot framework
    ...  build=[ECommerce Demo - 1] Action Chains with Robot framework
    ...  project=[ECommerce Project - 1] Action Chains with Robot framework

${BROWSER_CLOUD}	    ${lt_cloud_options['browserName']}
&{CAPABILITIES_CLOUD}     LT:Options=&{lt_cloud_options}

${expected_title}	Designs

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

Example 1: [Playground] Drag & Drop Mouse Operations Demo with Robot Framework
	[tags]  Drag & Drop Mouse Operations Demo
	[Timeout]   ${TIMEOUT}

	# Port of https://github.com/hjsblogger/selenium-automation-python-tutorial/
	# blob/main/tests/pytest/10_mouse_interactions.py#L18

	# Get Environment Variables
	Log To Console		Tests executed on: ${EXEC_PLATFORM}
	IF  '${EXEC_PLATFORM}' == 'local'
		${chrome_driver_path}=   Update Chrome Webdriver
		# Open local test browser	${site_url_1}		${BROWSER}
		Open local test browser 	${site_url_1}		${BROWSER_LOCAL}	${chrome_driver_path}
	ELSE IF  '${EXEC_PLATFORM}' == 'cloud'
		# [ WARN ] desired_capabilities has been deprecated and removed.
        # Please use options to configure browsers as per documentation.
		# Open test browser	${site_url_1}		${BROWSER_CLOUD}		${CAPABILITIES_CLOUD}
		Open test browser	${site_url_1}		${BROWSER_CLOUD}		${lt_cloud_options}
	END
	Maximize Browser Window

	Wait Until Element Is Visible  ${xDraggableFrame_1}  timeout=2
	Wait Until Element Is Visible  ${xDraggableFrame_2}  timeout=2
	Wait Until Element Is Visible  ${xDroppableFrame}  timeout=2

	${elem_draggable_1} = 	Get WebElement	${xDraggableFrame_1}
	${elem_draggable_2} =	Get WebElement 	${xDraggableFrame_2}
	${elem_droppable} =		Get WebElement 	${xDroppableFrame}

    Drag And Drop  ${elem_draggable_1}  ${elem_droppable}
	Sleep  2s
    Drag And Drop  ${elem_draggable_2}  ${elem_droppable}
	Sleep  2s
	Log    Completed - Drag & Drag Demo with Robot Framework

	[Teardown]  Test Teardown

Example 2: [Playground] Action Chains Robot framework
	[tags]  Action Chains Robot Framework
	[Timeout]   ${TIMEOUT}
	# Get Environment Variables
	Log To Console		Tests executed on: ${EXEC_PLATFORM}
	IF  '${EXEC_PLATFORM}' == 'local'
		# Open local test browser	${site_url_2}		${BROWSER}
		${chrome_driver_path}=    Update Chrome Webdriver
		# Open Browser    ${site_url_2}    chrome    executable_path=${chrome_driver_path}
		Open local test browser 	${site_url_2}		${BROWSER_LOCAL}	${chrome_driver_path}
	ELSE IF  '${EXEC_PLATFORM}' == 'cloud'
        # [ WARN ] desired_capabilities has been deprecated and removed.
        # Please use options to configure browsers as per documentation.
		# Open test browser	${site_url_2}		${BROWSER_CLOUD}		${CAPABILITIES_CLOUD}
        Open test browser	${site_url_2}		${BROWSER_CLOUD}		${lt_cloud_options}
	END
	Maximize Browser Window
	Move to Element
	Sleep	3s
	Click Menu Item
	Sleep	2s
	#Check the new page title
	${curr_page_title}  Get Title
	Log To Console		${curr_page_title}
	# https://robotframework.org/robotframework/latest/
	# libraries/BuiltIn.html#Should%20Be%20Equal%20As%20Strings
    Should Be Equal As Strings  ${curr_page_title}  ${expected_title}

	# Check if a particular element is present on the page
	${status}=	Page should contain element		${pageMessage}
	Log To Console		${status}
	Run Keyword If  '${status}' != 'None'  Fail  Element not found on page

	[Teardown]	Test Teardown