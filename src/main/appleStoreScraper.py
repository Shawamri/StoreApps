import time
from selenium import webdriver
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.by import By
from main.appleAppScraper import Scraper
from main.chromeOptions import set_chrome_options



class AppleScraper:
  def __init__(self):
     #init selenium driver and lists for to save the results in  
        self.list_of_pages_of_letters = []
        self.list_of_pages_numbers = []
        self.list_of_apps = []
        self.chrome_options = set_chrome_options()
        #self.options = webdriver.ChromeOptions()
        self.driver = webdriver.Chrome(options=self.chrome_options)
        self.driver.maximize_window()
        
  def get_letters(self,url):

        self.driver.get(url)
        #to have enough time to load the page
        time.sleep(5)
        elems = self.driver.find_elements(By.XPATH, "//a[@href]")
        if elems == None :return []
        #get the links of the letters
        for elem in elems:
            if ("letter="in elem.get_attribute("href")):
                if not (elem.get_attribute("href") in self.list_of_pages_of_letters):
                    self.list_of_pages_of_letters.append(elem.get_attribute("href"))
                    
        return self.list_of_pages_of_letters           
                   
        
        
        
        
        
        
  def get_nums_of_letter(self,letter):
        self.driver.get(letter)
        time.sleep(5)
        elems = self.driver.find_elements(By.XPATH, "//a[@href]")
        if elems == None:return []
        #get the links of the numbers
        for elem in elems:
            if "page=" in elem.get_attribute("href"):
                if not (elem.get_attribute("href") in self.list_of_pages_numbers):
                    self.list_of_pages_numbers.append(elem.get_attribute("href"))
        return(self.list_of_pages_numbers)
    
  def get_apps_num_letter(self,nr):
        self.driver.get(nr)
        time.sleep(5)
        SCROLL_PAUSE_TIME = 5
        # Get scroll height
        last_height = self.driver.execute_script("return document.body.scrollHeight")
        time.sleep(SCROLL_PAUSE_TIME)
        while True:
                # Scroll down to bottom
                self.driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
 
                # Wait to load page
                time.sleep(SCROLL_PAUSE_TIME)
 
                # Calculate new scroll height and compare with last scroll height
                new_height = self.driver.execute_script("return document.body.scrollHeight")
                if new_height == last_height:
                    break
                last_height = new_height
        elems = self.driver.find_elements(By.XPATH, "//a[@href]")
        if elems == None: return []
        #get the links of apps ,scrape them and save them in a list
        for elem in elems:
            if "https://apps.apple.com/de/app/"in elem.get_attribute("href"):
                if not (elem.get_attribute("href") in self.list_of_apps):
                    self.list_of_apps.append(Scraper().scrapApp(elem.get_attribute("href")))

        #return the list of apps datas 
        return self.list_of_apps
        
        
  def main(self,pageUrl):
    letters = self.get_letters(pageUrl)
    pages=[]
    for letter in letters:
        #just for testing 
        #there are more than 20.000 apps of each category!!
        if len(pages)<=2:
            pages = pages + self.get_nums_of_letter(letter)
        else:break
    apps=[]
    for page in pages:
        if len(apps)<=50:#just for testing
            apps = apps + self.get_apps_num_letter(page)
        else:break
  
    #close the browser 
    self.driver.close()
     #get the result    
    return apps






            

