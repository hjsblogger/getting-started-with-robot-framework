*** Settings ***
Library  SeleniumLibrary
Library  OperatingSystem
Library  BuiltIn
Library  ../Common/LambdaTestStatus.py

*** Variables ***
${REMOTE_URL}       http://%{LT_USERNAME}:%{LT_ACCESS_KEY}@hub.lambdatest.com/wd/hub
${TIMEOUT}          3000
${MENU_ITEM}        AddOns
${DESIGN_ITEM}      Designs

*** Keywords ***
Open test browser
    [Arguments]     ${TEST_URL}     ${BROWSER}      ${lt_options}
    [Timeout]       ${TIMEOUT}
    ${options}=    Evaluate      sys.modules['selenium.webdriver'].${BROWSER}Options()    sys, selenium.webdriver
    Call Method    ${options}    set_capability    LT:Options    ${lt_options}
    Open browser    ${TEST_URL}     ${BROWSER}
    ...    remote_url=${REMOTE_URL}
    # [ WARN ] desired_capabilities has been deprecated and removed.
    # Please use options to configure browsers as per documentation.
    # ...  desired_capabilities=${CAPABILITIES}
    ...    options=${options}

Close test browser
    Run keyword if  '${REMOTE_URL}' != ''
    ...  report lambdatest status
    ...  ${TEST_NAME}
    ...  ${TEST_STATUS}
    Close Browser

Open local test browser
    [Arguments]     ${TEST_URL}     ${BROWSER}      ${DRIVER_PATH}
    [Timeout]       ${TIMEOUT}
    Open browser    ${TEST_URL}     ${BROWSER}      executable_path=${DRIVER_PATH}

Close local test browser
    Close Browser

Move to Element
    [Documentation]    Hover over the menu item
    ${menu_item}=    Get WebElement    partial link=${MENU_ITEM}
    Mouse Over    ${menu_item}
    Sleep    1s    # equivalent of time.sleep(1)

Click Menu Item
    [Documentation]    Click the submenu item once it opens up
    Click Link      partial link=${DESIGN_ITEM}
    Sleep   10s
    # Wait Until Page Contains Element