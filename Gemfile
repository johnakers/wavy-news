# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.1.1'

gem 'rails', '~> 7.0.4' # Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'

gem 'bootsnap', require: false # Reduces boot times through caching; required in config/boot.rb
gem 'httparty' # gem for making nice HTTP requests
gem 'importmap-rails' # Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem 'pg', '~> 1.1' # Use postgresql as the database for Active Record
gem 'puma', '~> 5.0' # Use the Puma web server [https://github.com/puma/puma]
gem 'sprockets-rails' # The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem 'stimulus-rails' # Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem 'turbo-rails' # Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]

group :development, :test do
  gem 'factory_bot_rails' # Creates mock data for testing purposes
  gem 'pry-byebug' # my favorite debugger
end

group :development do
  gem 'web-console' # Use console on exceptions pages [https://github.com/rails/web-console]
end

group :test do
  gem 'rspec-rails'
end
