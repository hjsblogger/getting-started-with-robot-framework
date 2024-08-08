### Inspiration of solution for Selenium 4.9.0 & above (i.e. Selenium Manager is introduced)
### https://forum.robotframework.org/t/
### nosuchdriverexception-message-unable-to-obtain-driver-for-chrome-using-selenium-manager/6697/6

*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Library    Collections

*** Variables ***
${CHROME_DRIVER_MANAGER}    webdriver_manager.chrome.ChromeDriverManager
${GECKO_DRIVER_MANAGER}     webdriver_manager.firefox.GeckoDriverManager
${EDGE_DRIVER_MANAGER}      webdriver_manager.microsoft.EdgeChromiumDriverManager

*** Keywords ***
Update Chrome Webdriver
    [Documentation]    Update Chrome Web Driver
    ${driverpath}=     Evaluate    ${CHROME_DRIVER_MANAGER}().install()    modules=webdriver_manager.chrome
    Log                Chrome driver path: ${driverpath}
    RETURN             ${driverpath}

Update Firefox Webdriver
    [Documentation]    Update Firefox Web Driver
    ${driverpath}=     Evaluate    ${GECKO_DRIVER_MANAGER}().install()    modules=webdriver_manager.firefox
    Log                Firefox driver path: ${driverpath}
    RETURN             ${driverpath}

Update Edge Webdriver
    [Documentation]    Update Brave Web Driver
    ${driverpath}=     Evaluate    ${EDGE_DRIVER_MANAGER}().install()    modules=webdriver_manager.microsoft
    Log                Brave driver path: ${driverpath}
    RETURN             ${driverpath}
