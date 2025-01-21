require 'selenium-webdriver'

# Function to run test on specified browser
def run_test(browser)
  # Set browser options based on input
  case browser
  when 'chrome'
    options = Selenium::WebDriver::Options.chrome
  when 'firefox'
    options = Selenium::WebDriver::Options.firefox
  when 'edge'
    options = Selenium::WebDriver::Options.edge
  else
    puts "Unsupported browser: #{browser}"
    return
  end

  # Connect to the Selenium Grid Hub
  driver = Selenium::WebDriver.for(:remote, url: 'http://192.168.1.23:4444/wd/hub', options: options)

  begin
    # Navigate to Google
    driver.navigate.to "https://www.google.com"
    puts "Opened Google on #{browser}"

    # Find the search box and perform a search
    search_box = driver.find_element(name: 'q')
    search_box.send_keys("Selenium Grid testing with Ruby")
    search_box.submit

    # Wait for the page to load
    sleep 5

    # Print the page title to confirm test success
    puts "#{browser} test passed! Page title is: #{driver.title}"

  rescue StandardError => e
    puts "#{browser} test failed with error: #{e.message}"
  ensure
    driver.quit
    puts "#{browser} test completed successfully!"
  end
end

# Running tests on multiple browsers
['chrome', 'firefox', 'edge'].each do |browser|
  run_test(browser)
end
