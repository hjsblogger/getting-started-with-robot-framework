# Test is a replica of: https://github.com/hjsblogger/web-scraping-with-python/
# blob/main/tests/beautiful-soup/test_infinite_scraping.py
*** Settings ***

Resource  	../../Resources/PageObject/KeyDefs/Common.robot
Resource  	../../Resources/PageObject/KeyDefs/SeleniumDrivers.robot
Variables 	../../Resources/PageObject/Locators/Locators.py

Library     SeleniumLibrary
Library     OperatingSystem
Library     BuiltIn

*** Variables ***
${site_url}  https://scrapingclub.com/exercise/list_infinite_scroll/
${SCROLL_PAUSE_TIME}  2s

*** Keywords ***
Scroll Down
    Execute JavaScript  window.scrollTo(0, document.body.scrollHeight)

Get Window Height
    ${height} =  Execute JavaScript  return document.body.scrollHeight
    RETURN             ${height}

*** Variables ***

${EXEC_PLATFORM}  %{EXEC_PLATFORM}

&{lt_local_options}
    ...  browserName=Chrome

${BROWSER_LOCAL}	  	  	${lt_local_options['browserName']}

&{lt_cloud_options}
    ...  browserName=Chrome
    ...  platformName=Windows 11
    ...  browserVersion=latest-1
    ...  visual=true
    ...  console=true
    ...	 w3c=true
    ...	 geoLocation=US
    ...  name=[Infinite Test - 1] Handling scroll with Robot framework
    ...  build=[Infinite Test Demo - 1] Handling scroll with Robot framework
    ...  project=[Infinite Test Project - 1] Handling scroll with Robot framework

${BROWSER_CLOUD}	    ${lt_cloud_options['browserName']}
&{CAPABILITIES_CLOUD}     LT:Options=&{lt_cloud_options}

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
Click Element Infinite Scroll
    # Get Environment Variables
	Log To Console		Tests executed on: ${EXEC_PLATFORM}
	IF  '${EXEC_PLATFORM}' == 'local'
	    ${chrome_driver_path} =   Update Chrome Webdriver
	    Open local test browser 	${site_url}		${BROWSER_LOCAL}	${chrome_driver_path}
    ELSE IF  '${EXEC_PLATFORM}' == 'cloud'
        # [ WARN ] desired_capabilities has been deprecated and removed.
        # Please use options to configure browsers as per documentation.
		# Open test browser	${site_url}		${BROWSER_CLOUD}		${CAPABILITIES_CLOUD}
        Open test browser	${site_url}		${BROWSER_CLOUD}		${lt_cloud_options}
	END
    Maximize Browser Window
    # Refer - https://github.com/hjsblogger/web-scraping-with-python/
    # blob/main/tests/beautiful-soup/test_infinite_scraping.py#L67
    WHILE  ${True}
        ${start_height} =  Get Window Height
        Scroll Down
        Sleep  ${SCROLL_PAUSE_TIME}
        ${scroll_height} =  Get Window Height
        Run Keyword If  '${start_height}' == '${scroll_height}'  Exit For Loop
        # Refer - https://github.com/hjsblogger/web-scraping-with-python/
        # blob/main/tests/beautiful-soup/test_infinite_scraping.py#L78
	END

    # Now all the products are loaded since we have reached the end of site
    # Check if a the respective product is present in the DOM
	${status}=	Page should contain element		${xProduct}
	Log To Console		${status}
	Run Keyword If  '${status}' != 'None'  Fail  Element not found on page
    # If it reaches here, the product is available on the page
    Click Element       ${xProduct}
    Sleep   ${SCROLL_PAUSE_TIME}
    # Community Rocks :) https://forum.robotframework.org/t/
    # wait-for-complete-page-load-in-robot-framework/4597/2
    Wait For Condition	return document.readyState == "complete"
    Log To Console      Completed - Infinite Scroll with Robot Framework

    [Teardown]  Test Teardown