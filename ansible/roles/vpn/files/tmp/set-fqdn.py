from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.by import By
from selenium.webdriver.firefox.options import Options

import sys
import re

if (len(sys.argv) != 2):
    print("Usage: ./set-fqdn.py fqdn")
    exit(1)

with open("/tmp/install_log", "r") as f:
    text = f.read()

p = re.compile("https://.*sslip.*")
temp_url = p.findall(text)[0] + "quick-setup"

fqdn = sys.argv[1]

# Enable headless version
options = Options()
# options.headless = True
options.add_argument("-headless")

# Create a new instance of the Firefox driver
driver = webdriver.Firefox(options=options)

# Open the web page
driver.get(temp_url)

# Find the text field element by its ID or any other attribute
text_field = driver.find_element(By.NAME, 'domain')

# Clear the existing text in the field (if any)
text_field.clear()

# Enter the desired text into the text field
text_field.send_keys(fqdn)
text_field.send_keys(Keys.ENTER)

# Submit the form by finding the submit button element and clicking it
# submit_button = driver.find_element_by_id('submit_button_id')
# submit_button.click()
result = False
if ('quick-setup' not in driver.current_url):
    result = True

# Close the browser
driver.quit()

