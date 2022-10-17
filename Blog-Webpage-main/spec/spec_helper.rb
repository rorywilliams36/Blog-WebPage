require "simplecov"
SimpleCov.start do
  add_filter "/spec/"
end
SimpleCov.coverage_dir "coverage"

ENV["APP_ENV"] = "test"

require_relative "../app"

require "capybara/rspec"
Capybara.app = Sinatra::Application

def app
  Sinatra::Application
end
RSpec.configure do |config|
  config.include Capybara::DSL
  config.include Rack::Test::Methods
end

def test_login 
  visit "/login"
  fill_in "username", with: "test"
  fill_in "password", with: "Testing1@"
  click_button "Submit"
end

def test_post_blog
  test_login
  visit "/blog"
  fill_in "post_title", with: "Post Title"
  fill_in "post_organization", with: "Post Organization"
  fill_in "post_content", with: "Post Body"
  click_button "Post"
end

def test_register_user
  visit "/register"
  fill_in "username", with: "test"
  fill_in "title", with: "test"
  fill_in "firstname", with: "test"
  fill_in "surname", with: "test"
  fill_in "password", with: "Testing1@"
  fill_in "confirm_password", with: "Testing1@"
  fill_in "email", with: "test@testing.com"
  fill_in "phonenumber", with: "888888888"
  fill_in "dateofbirth", with: "1999-10-29"
  fill_in "university", with: "University of Test"
  click_button "Sign Up"
end

def clear_database
  DB.from("posts").delete
  DB.from("users").delete
end

def create_admin
  test_register_user
  DB[:users].where(userID: 1).update(userType: "ADMINISTRATOR") 
end

def create_post
  visit "/blog"
  fill_in "post_title", with: "Post Title"
  fill_in "post_organization", with: "Post Organization"
  fill_in "post_content", with: "Post Body"
  click_button "Post"
end

def hide_post
  create_post
  create_admin
  test_login

  visit "/post?id=1"
  click_button "Hide"
end

clear_database