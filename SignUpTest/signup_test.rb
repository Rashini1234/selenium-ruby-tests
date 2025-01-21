require 'selenium-webdriver'
require 'rspec'

RSpec.describe "Blog Application" do
  describe "Signup to the Blog Application" do
    it "confirms that a user can successfully sign up" do
      driver = Selenium::WebDriver.for :firefox
      driver.manage.window.maximize

      driver.navigate.to "https://selenium-blog.herokuapp.com/signup"

      wait = Selenium::WebDriver::Wait.new(timeout: 10)

      username_field = wait.until { driver.find_element(id: 'user_username') }
      email_field = driver.find_element(id: 'user_email')
      password_field = driver.find_element(id: 'user_password')
      signup_button = driver.find_element(id: 'submit')

      username_field.send_keys("newuser123")
      email_field.send_keys("newuser123@example.com")
      password_field.send_keys("password123")
      signup_button.click

      sleep 5
      banner = wait.until { driver.find_element(id: 'flash_success') }
      banner_text = banner.text

      expect(banner_text).to eq("Welcome to the alpha blog user.")

      driver.quit
    end
  end
end
