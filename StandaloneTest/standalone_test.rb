require 'selenium-webdriver'

# Function to run test on a specified browser
def run_test(browser)
  options = case browser
            when 'chrome'
              Selenium::WebDriver::Options.chrome
            when 'firefox'
              Selenium::WebDriver::Options.firefox
            when 'edge'
              Selenium::WebDriver::Options.edge
            else
              puts "Unsupported browser: #{browser}"
              return
            end

  # Connect to Selenium Standalone Server running locally
  driver = Selenium::WebDriver.for(:remote, url: 'http://localhost:4444/wd/hub', options: options)

  begin
    # Open Google
    driver.navigate.to "https://www.google.com"
    puts "Opened Google on #{browser}"

    # Search for Selenium Grid
    search_box = driver.find_element(name: 'q')
    search_box.send_keys("Selenium Grid Standalone Test with Ruby")
    search_box.submit

    # Wait for results to load and print the page title
    sleep 5
    puts "#{browser.capitalize} test passed! Page title is: #{driver.title}"

  rescue StandardError => e
    puts "#{browser.capitalize} test failed with error: #{e.message}"
  ensure
    driver.quit
    puts "#{browser.capitalize} test completed successfully!"
  end
end

# Run the test on Chrome, Firefox, and Edge
['chrome', 'firefox', 'edge'].each do |browser|
  run_test(browser)
end
