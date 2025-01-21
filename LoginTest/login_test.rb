require 'selenium-webdriver'

driver = Selenium::WebDriver.for :firefox
driver.manage.window.maximize

driver.navigate.to "https://practicetestautomation.com/practice-test-login/"

username_field = driver.find_element(id: 'username')
password_field = driver.find_element(id: 'password')
login_button = driver.find_element(id: 'submit')

username_field.send_keys("student")
password_field.send_keys("Password123")

login_button.click

sleep 5

if driver.page_source.include?("Logged In Successfully")
    puts "Test passed"
else
    puts "Test failed"
end

driver.quit

puts "Test completed successfully!"
