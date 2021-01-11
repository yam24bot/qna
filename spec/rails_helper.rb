require 'factory_bot'
require 'shoulda/matchers'
require 'spec_helper'

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'
Dir[Rails.root.join('spec/support/**/*.rb')].sort.each { |f| require f }

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new app, browser: :chrome,
                                      options: Selenium::WebDriver::Chrome::Options.new(args: %w[headless disable-gpu])
end

Capybara.javascript_driver = :chrome

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end
RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  config.include Devise::TestHelpers, type: :controller
  config.include AcceptanceHelper, type: :feature

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:suite) do
    FactoryBot.find_definitions
  end

  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = false

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before do
    DatabaseCleaner.start
  end

  config.after do
    DatabaseCleaner.clean
  end
end
