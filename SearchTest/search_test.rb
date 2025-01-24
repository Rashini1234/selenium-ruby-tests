require 'selenium-webdriver'

# Define test data
search_url = "https://www.google.com"
search_query = "Selenium WebDriver"
expected_result = "Selenium WebDriver"

# Define a function to perform search test
def run_search_test(browser, url, query, expected)
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

  driver = Selenium::WebDriver.for(:remote, url: 'http://localhost:4444/wd/hub', options: options)

  begin
    driver.navigate.to url
    puts "Opened #{url} on #{browser}"

    # Find the search box and perform a search
    search_box = driver.find_element(name: 'q')
    search_box.send_keys(query)
    search_box.submit

    sleep 3  # Wait for results to load

    # Check if the results contain the expected text
    if driver.page_source.include?(expected)
      puts "#{browser.capitalize} Search Test Passed! Found expected text."
    else
      puts "#{browser.capitalize} Search Test Failed! Expected text not found."
    end

  rescue StandardError => e
    puts "#{browser.capitalize} test encountered an error: #{e.message}"
  ensure
    driver.quit
    puts "#{browser.capitalize} test completed successfully!"
  end
end

# Run the test on Chrome, Firefox, and Edge
['chrome', 'firefox', 'edge'].each do |browser|
  run_search_test(browser, search_url, search_query, expected_result)
end
