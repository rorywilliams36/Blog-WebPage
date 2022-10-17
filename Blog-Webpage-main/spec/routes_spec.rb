require "rspec"
require "rack/test"


require_relative "spec_helper"

RSpec.describe do
    include Rack::Test::Methods

    def app
        Sinatra::Application
    end

    describe "GET/" do
        it "has a status code of 200 (OK)" do
            get "/"
            expect(last_response).to be_ok
        end

        it "Has 'Home', 'Login', 'Blog', 'Profile'" do
            get "/"
            expect(last_response.body).to include("Home", "Login", "Blog", "Profile")
        end
    end

    describe "GET/home" do
        it "has a status code of 200 (OK)" do
            get "/home"
            expect(last_response).to be_ok
        end
    end

    describe "GET/login" do
        it "has a status code of 200 (OK)" do
            get "/login"
            expect(last_response).to be_ok
        end

        it "Has 'Login', 'Username', 'Password'" do
            get "/login"
            expect(last_response.body).to include("Login", "Username", "Password")
        end

    end

    describe "GET/blog" do
        it "has a status code of 200 (OK)" do
            get "/blog"
            expect(last_response).to be_ok
        end

        it "Has 'Title', 'Organization', 'Body'" do
            get "/blog"
            expect(last_response.body).to include( "Title", "Organization", "Body")
        end

    end

    describe "GET/admin" do
        it "has a status code of 200 (OK)" do
            get "/admin"
            expect(last_response).to be_ok
        end
    end

    describe "GET/admin_posts" do
        it "has a status code of 200 (OK)" do
            get "/admin_posts"
            expect(last_response).to be_ok
        end
    end

    describe "GET/admin_users" do
        it "has a status code of 200 (OK)" do
            get "/admin_users"
            expect(last_response).to be_ok
        end
    end

    describe "GET/register" do
        it "has a status code of 200 (OK)" do
            get "/register"
            expect(last_response).to be_ok
        end

        it "Has 'Let's Make an Account!" do
            get "/register"
            expect(last_response.body).to include( "Let's Make an Account!")
        end
    end
    
    describe "GET/edit" do
        it "has a status code of 200 (OK)" do
            test_register_user
            test_login
            get "/edit/name?id=1"
            expect(last_response).to be_ok
            clear_database
        end

        it "has a status code of 200 (OK)" do
            test_register_user
            test_login
            get "/edit/university?id=1"
            expect(last_response).to be_ok
            clear_database
        end

        it "has a status code of 200 (OK)" do
            test_register_user
            test_login
            get "/edit/phoneNumber?id=1"
            expect(last_response).to be_ok
            clear_database
        end

        it "has a status code of 200 (OK)" do
            test_register_user
            test_login
            get "/edit/email?id=1"
            expect(last_response).to be_ok
            clear_database
        end

        it "has a status code of 200 (OK)" do
            test_register_user
            test_login
            get "/edit/dateOfBirth?id=1"
            expect(last_response).to be_ok
            clear_database
        end
    end
end