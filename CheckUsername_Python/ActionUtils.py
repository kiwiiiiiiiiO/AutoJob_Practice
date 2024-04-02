from selenium.webdriver.support.wait import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC


class ActionUtils():
    def __init__(self, driver):
        self.driver = driver
    
    def find_presence_elem(self, locator, timeout=10):
        return WebDriverWait(self.driver, timeout).until(
            EC.presence_of_element_located(locator)
        )
    
    def find_visible_elem(self, locator, timeout=10):
        return WebDriverWait(self.driver, timeout).until(
            EC.visibility_of_element_located(locator)
        )
    
    def find_clickable_elem(self, locator, timeout=10):
        return WebDriverWait(self.driver, timeout).until(
            EC.element_to_be_clickable(locator)
        )
    
    def visibility_elem(self, locator, timeout=10):
        return WebDriverWait(self.driver, timeout).until(
            EC.visibility_of(locator)
        )
    
    def text_present_in_element(self, locator, timeout=10, text=''):    ## return boolean
        return WebDriverWait(self.driver, timeout).until(
            EC.text_to_be_present_in_element(locator, text)
        )

