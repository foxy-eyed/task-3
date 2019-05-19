require "rails_helper"

Capybara.server = :puma, { Silent: true }
Capybara.default_max_wait_time = 5

Dir[Rails.root.join("spec/system/shared_examples/**/*.rb")].each { |f| require f }

Capybara.register_driver :headless_chrome do |app|
  Capybara::Selenium::Driver.new app,
        browser: :chrome,
        desired_capabilities: Selenium::WebDriver::Remote::Capabilities.chrome(
          chromeOptions: {
            args: %w[headless
                     disable-gpu
                     no-sandbox
                     window-size=1400,2000
                     enable-features=NetworkService,NetworkServiceInProcess]
          },
        )
end

RSpec.configure do |config|
  config.include Devise::Test::IntegrationHelpers, type: :system

  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  config.before(:each, type: :system, js: true) do
    driven_by :headless_chrome
  end
end
