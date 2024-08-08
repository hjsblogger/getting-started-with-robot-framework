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
    [Arguments]     ${TEST_URL}     ${BROWSER}      ${CAPABILITIES}
    [Timeout]       ${TIMEOUT}
    Open browser    ${TEST_URL}     ${BROWSER}
    ...  remote_url=${REMOTE_URL}
    ...  desired_capabilities=${CAPABILITIES}

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

Move to Element local test browser
    [Documentation]    Hover over the menu item
    ${menu_item}=    Get WebElement    partial link=${MENU_ITEM}
    Mouse Over    ${menu_item}
    Sleep    1s    # equivalent of time.sleep(1)

Click Menu Item local test browser
    [Documentation]    Click the submenu item once it opens up
    Click Link      partial link=${DESIGN_ITEM}
    Sleep   10s
    # Wait Until Page Contains Element