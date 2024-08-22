*** Settings ***

Resource  	../../Resources/PageObject/KeyDefs/Common.robot
Resource  	../../Resources/PageObject/KeyDefs/SeleniumDrivers.robot
Variables 	../../Resources/PageObject/Locators/Locators.py

Test Teardown  Common.Close local test browser

Library    	BuiltIn
Library		OperatingSystem

*** Variables ***

${site_url_1}  		https://www.lambdatest.com/selenium-playground/

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
    ...  browserVersion=latest-4
    ...  visual=true
    ...	 w3c=true
    ...	 geoLocation=US
    ...  name=[Playground - 1] Parallel Testing with Robot framework
    ...  build=[Playground Demo - 1] Parallel Testing with Robot framework
    ...  project=[Playground Project - 1] Parallel Testing with Robot framework

${BROWSER_CLOUD}	    	${lt_cloud_options['browserName']}
&{CAPABILITIES_CLOUD}     	LT:Options=&{lt_cloud_options}

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

Example 1: [Playground] Send Keys Demo with Robot Framework
	[tags]  Selenium Playground Automation
	[Timeout]   ${TIMEOUT}
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
	Page should contain element  xpath://a[.='Input Form Submit']

	Click link  ${SubmitButton}
	Page should contain element  ${Name}
	# Enter details in the input form

	# Name
	Input text  ${Name}   TestName
	# Email
	Input text  ${email}       testing@gmail.com
        # Password  
	Input text  ${passwd}       Password1
	# Company 
	Input text  ${company}      LambdaTest
	# Website
	Input text  ${website}      https://wwww.lambdatest.com
	# Country
	select from list by value    ${country}     US
        # City
	Input text  ${city}       San Jose
	# Address 1
	Input text  ${address1}      Googleplex, 1600 Amphitheatre Pkwy
	# Website
	Input text  ${address2}       Mountain View, CA 94043
	# State
	Input text    ${state}          California
        # City
	Input text  ${city}       San Jose
	# Zip Code
	Input text  ${zipcode}      94088
	Sleep  5s

	Click button  	  ${FinalSubmission}
	Execute JavaScript    window.scrollTo(0, 0)
	Page should contain  ${SuccessText}
	Sleep  2s
        Log    Completed - Example 2: [Playground] Parallel Testing with Robot framework

	[Teardown] 	Test Teardown

# This example is repetitive, need to have better organization for actual code!
Example 2: [Playground] Press Keys Demo with Robot Framework
	[tags]  Selenium Playground Automation
	[Timeout]   ${TIMEOUT}
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
	Page should contain element  xpath://a[.='Input Form Submit']

	Click link  ${SubmitButton}
	Page should contain element  ${Name}
	# Enter details in the input form

	# Name
	Press Keys  ${Name}   Himanshu+SPACE+Sheth
	# Email
	Press Keys  ${email}       testing@gmail.com
    # Password  
	Press Keys  ${passwd}       Password1
	# Company 
	Press Keys  ${company}      LambdaTest
	# Website
	Press Keys  ${website}      https://wwww.lambdatest.com
	# Country
	select from list by value    ${country}     US
    # City
	Press Keys  ${city}       San Jose
	# Address 1
	Press Keys  ${address1}      Googleplex, 1600 Amphitheatre Pkwy
	# Website
	Press Keys  ${address2}       Mountain View, CA 94043
	# State
	Press Keys    ${state}          California
	# Zip Code
	Press Keys  ${zipcode}      94088
	Sleep  5s

	Click button  	  ${FinalSubmission}
	Execute JavaScript    window.scrollTo(0, 0)
	Page should contain  ${SuccessText}
	Sleep  2s
        Log    Completed - Example 2: [Playground] Parallel Testing with Robot framework

	[Teardown] 	Test Teardown