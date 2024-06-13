*** Settings ***
Documentation   A test for login HOST and check username is showed.
Library         SeleniumLibrary
Suite Teardown  Close Browser   

*** Variables ***
${HOST}          None
${USERNAME}      None
${PASSWORD}      None
${Login Dir 1}           None
${Login Dir 2}           None
${Popup Window Dir 1}    None
${Verify Dir 1}            None
${Logout Dir 1}            None


*** Test Cases ***
Multiple Process
    Open HOST    ${HOST}
    Login    ${USERNAME}   ${PASSWORD}
    Handle popup window
    Verify username     ${USERNAME}
    Logout   


*** Keywords ***
Open HOST
    [Documentation]   Open HOST
    [Arguments]    ${url}
    Open Browser  ${url}    browser=chrome  executable_path=CheckUsername_SeleniumLibrary\\chromedriver-win64\\chromedriver.exe

Login
    [Documentation]    Login HOST
    [Arguments]    ${username}    ${password}
    Wait Until Page Contains Element    id:username
    Input Text    id:username    ${username} 
    Capture Page Screenshot    ${Login Dir 1} 
    Click Element    xpath://button[@class="login"]
    Wait Until Element Is Visible   id:pwd
    Input Text    id:pwd   ${password}
    Capture Page Screenshot    ${Login Dir 2} 
    Click Element    xpath://button[@class="login"]

Handle popup window
    [Documentation]    Handle the popup window for updating
    Sleep   25s
    Wait Until Element Is Visible    xpath://div[@class="close"]
    Wait Until Element Is Visible   xpath://button[@class="close"]
    Capture Page Screenshot   ${Popup Window Dir 1}
    Click Element     xpath://button[@class="close"]

Verify username
    [Documentation]    Verify the username has showed in the right position
    [Arguments]    ${username}
    Capture Page Screenshot   ${Verify Dir 1} 
    Element Text Should Be    xpath://button[@class="username"]    expected=${username}    message= Username is not showed correctly

Logout
    [Documentation]    Logout HOST
    Click Element     xpath://button[@id="ext-gen161"]
    Wait Until Element Is Visible   xpath://button[@class="logout"]
    Capture Page Screenshot    ${Logout Dir 1}
    Click Element    xpath://button[@class="logout"]
