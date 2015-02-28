ENV["RAILS_ENV"] ||= 'test'
require 'spec_helper'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

Rails.application.railties.to_a { |r| r.eager_load! }

Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

ActiveRecord::Migration.maintain_test_schema! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  config.use_transactional_fixtures = false
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"
  config.infer_spec_type_from_file_location!

  # For capybara
  require 'capybara/rspec'
  require 'capybara/poltergeist'
  Capybara.register_driver :poltergeist do |app|
    Capybara::Poltergeist::Driver.new(app, timeout: 360)
  end
  Capybara.javascript_driver = :poltergeist

  # For database cleaner
  config.before(:suite) do
    DatabaseRewinder.clean_all
  end

  config.before(:all) do
    FactoryGirl.reload
  end

  config.before(:each) do |example|
    Rails.cache.clear
    load Rails.root.join('db', 'seeds.rb')

    if example.metadata[:js]
      page.driver.resize(1024, 2048)
    end
    I18n.locale = (ENV['CI'] == 'ON') ? :en : :ja
  end

  config.after(:each) do
    DatabaseRewinder.clean
  end

  # macro
  config.include FeatureMacros, type: :feature

  # factory_girl
  config.include FactoryGirl::Syntax::Methods

  # faker
  Faker::Config.locale = :en
end
