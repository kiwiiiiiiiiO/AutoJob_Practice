*** Settings ***
Documentation   A test for login HOST and check username is showed.
Library    FunctionModule.py


*** Variables ***
${HOST}                  None
${USERNAME}              None
${PASSWORD}              None
${Login Dir 1}           None
${Login Dir 2}           None
${Popup Window Dir 1}    None
${Popup Window Dir 2}    None
${Logout Dir 1}            None
${Logout Dir 2}            None

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
