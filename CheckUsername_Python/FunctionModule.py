from selenium import webdriver
from selenium.webdriver.common.by import By
import time
from robot.api import logger
from ActionUtils import ActionUtils

class FunctionModule(ActionUtils):
    
    ROBOT_LIBRARY_SCOPE = 'GLOBAL'
    
    # 把 locator 以 tuple 形態存儲成 FunctionModule 的 attribute
    username_text_field = (By.XPATH, 'username')
    next_button = (By.XPATH,'Login')
    password_text_field = (By.XPATH, 'pwd')
    submit_button = (By.XPATH, 'Submit')
    popup_window = (By.XPATH, 'Popup window')
    popup_window_button = (By.XPATH, 'Close')
    username_button = (By.XPATH, 'Username')
    logout_span = (By.XPATH, 'Logout Span)

    def __init__(self):
        self.driver = None

    def connect_driver(self, host):
        self.host = host
        self.driver = webdriver.Chrome(executable_path="CheckUsername_Python\\chromedriver-win64\\chromedriver.exe")
        self.driver.get(self.host)

    def set_username(self, username, login_dir_1):
        try:
            self.username = username
            username_elem = self.find_presence_elem( self.username_text_field, 5 )
            username_elem.send_keys( self.username )      
            self.driver.save_screenshot( login_dir_1 )
            next_button_elem = self.find_presence_elem( self.next_button ,5)
            next_button_elem.click()
        except TimeoutError:
            return "Set Username time out"
    
    def set_password(self, password, login_dir_2):
        try:
            self.password = password
            password_elem = self.find_visible_elem( self.password_text_field, 5 )
            password_elem.send_keys( self.password )
            self.driver.save_screenshot( login_dir_2 )
            submit_button_elem = self.find_presence_elem( self.submit_button ,5)
            submit_button_elem.click()
        except TimeoutError:
            return "Set Password time out"
    

    def handle_popup_window(self, popupwindow_dir_1, popupwindow_dir_2):
        try:
            popupwindow_elem = self.find_presence_elem( self.popup_window, 30)
            popupwindow_button_elem = self.find_presence_elem( self.popup_window_button, 10)
            self.driver.save_screenshot( popupwindow_dir_1 )
            popupwindow_button_elem.click()
            self.driver.save_screenshot( popupwindow_dir_2 )
            return "Success"
        except TimeoutError:
            return "Handel Popup Window time out"

    def check_username(self, username):
        try:
            result = self.text_present_in_element( self.username_button, 5 , username)
            if result == False:
                raise   Exception
            return "Verify Success!!"
        except Exception as e:
             return "Username is not showed correctly"
    
    def logout(self, logout_dir_1, logout_dir_2):
        try:
            username_button_elem = self.find_visible_elem( self.username_button, 5)
            username_button_elem.click()
            logout_span_elem = self.find_presence_elem(self.logout_span, 5 )
            self.driver.save_screenshot(  logout_dir_1 )
            logout_span_elem.click()
            self.driver.save_screenshot(  logout_dir_2 )
        except TimeoutError:
            return "Handel Popup Window time out"
        
        
