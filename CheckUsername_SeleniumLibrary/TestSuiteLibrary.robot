*** Settings ***
Documentation   A test for login HOST and check username is showed.
Library         SeleniumLibrary
Suite Teardown  Close Browser   

*** Variables ***
${HOST}          #url
${USERNAME}      #username
${PASSWORD}      #passsword
${Login Dir 1}           DIR/CheckUsername_Python/screenshot/Login_1.png
${Login Dir 2}           DIR/CheckUsername_Python/screenshot/Login_2.png
${Popup Window Dir 1}    DIR/CheckUsername_Python/screenshot/PopupWindow_1.png
${Verify Dir 1}            DIR/CheckUsername_Python/screenshot/Verify_1.png
${Logout Dir 1}            DIR/CheckUsername_Python/screenshot/Logout_1.png


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
    Click Element    xpath://button[@class="login-btn HOST pre-login"]
    Wait Until Element Is Visible   id:pwd
    Input Text    id:pwd   ${password}
    Capture Page Screenshot    ${Login Dir 2} 
    Click Element    xpath://button[@class="login-btn HOST submit"]

Handle popup window
    [Documentation]    Handle the popup window for updating
    Sleep   25s    ## 彈出視窗需要一段時間(有時會超過20秒)才會跳出
    Wait Until Element Is Visible    xpath://div[@id="ext-comp-1293"]
    Wait Until Element Is Visible   xpath: //button[.//text() = "Close"] 
    Capture Page Screenshot   ${Popup Window Dir 1}
    Click Element     xpath: //button[.//text() = "Close"] 

Verify username
    [Documentation]    Verify the username has showed in the right position
    [Arguments]    ${username}
    Capture Page Screenshot   ${Verify Dir 1} 
    Element Text Should Be    xpath://button[@id="ext-gen161"]    expected=${username}    message= Username is not showed correctly

Logout
    [Documentation]    Logout HOST
    Click Element     xpath://button[@id="ext-gen161"]
    Wait Until Element Is Visible   xpath: //span[.//text() = "Logout"] 
    Capture Page Screenshot    ${Logout Dir 1}
    Click Element    xpath: //span[.//text() = "Logout"] 
