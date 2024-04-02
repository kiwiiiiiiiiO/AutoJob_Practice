*** Settings ***
Documentation   A test for login HOST and check username is showed.
Library    FunctionModule.py


*** Variables ***
${HOST}                  #url
${USERNAME}              #username
${PASSWORD}              #password
${Login Dir 1}           DIR/CheckUsername_Python/screenshot/Login_1.png
${Login Dir 2}           DIR/CheckUsername_Python/screenshot/Login_2.png
${Popup Window Dir 1}    DIR/CheckUsername_Python/screenshot/PopupWindow_1.png
${Popup Window Dir 2}    DIR/CheckUsername_Python/screenshot/PopupWindow_2.png
${Logout Dir 1}            DIR/CheckUsername_Python/screenshot/Logout_1.png
${Logout Dir 2}            DIR/CheckUsername_Python/screenshot/Logout_2.png

*** Test Cases ***
Multiple Process
    Open HOST   url=${HOST}
    Login HOST  username=${USERNAME}    password=${PASSWORD}    login_dir_1=${Login Dir 1}    login_dir_2=${Login Dir 2}
    Cancle Update    popupwindow_dir_1=${Popup Window Dir 1}     popupwindow_dir_2=${Popup Window Dir 2}
    Verify Username    username=${USERNAME}
    Logout HOST   logout_dir_1=${Logout Dir 1}    logout_dir_2=${Logout Dir 2}


*** Keywords ***
Open HOST 
    [Arguments]    ${url}
    Connect Driver    host=${url} 

Login HOST
    [Arguments]    ${username}    ${password}    ${login_dir_1}    ${login_dir_2}  
    Set Username    ${username}    login_dir_1=${login_dir_1} 
    Set Password    password=${password}    login_dir_2=${login_dir_2}

Cancle Update
    [Arguments]    ${popupwindow_dir_1}    ${popupwindow_dir_2}
    Handle Popup Window    popupwindow_dir_1=${popupwindow_dir_1}    popupwindow_dir_2=${popupwindow_dir_2}   

Verify Username
    [Arguments]    ${username}
    ${Result} =    Check Username    username=${username}
    Log To Console    message=${Result}
    
Logout HOST  
    [Arguments]    ${logout_dir_1}    ${logout_dir_2} 
    Logout    logout_dir_1=${logout_dir_1}    logout_dir_2=${logout_dir_2}