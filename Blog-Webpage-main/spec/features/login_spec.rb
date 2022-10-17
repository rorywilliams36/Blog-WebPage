require_relative "../spec_helper"

describe "the login page" do
  it "will login when all correct details are entered" do
    # User has to be registered in order to do this testing
    test_register_user
    test_login
    expect(page).to have_content "Recent Posts:"
    clear_database
  end

  it "will not login when incorrect details are entered" do
    visit "/login"
    fill_in "username", with: "incorrectTest"
    fill_in "password", with: "incorrectTest"
    click_button "Submit"
    #When you submit the form with incorrect details it loads again the Login Page
    #therefore it will show the content of the Login Page
    #to make it better, errors like in register.rb should be used
    expect(page).to have_content "Username or password is invalid"
    clear_database
  end

  it "will not login when incorrect username is entered" do
    visit "/login"
    fill_in "username", with: "incorrectTest"
    fill_in "password", with: "Testing1@"
    click_button "Submit"
    #When you submit the form with incorrect details it loads again the Login Page
    #therefore it will show the content of the Login Page
    #to make it better, errors like in register.rb should be used
    expect(page).to have_content "Username or password is invalid"
    clear_database
  end

  it "will not login when incorrect password is entered" do
    visit "/login"
    fill_in "username", with: "test"
    fill_in "password", with: "incorrectTest"
    click_button "Submit"
    #When you submit the form with incorrect details it loads again the Login Page
    #therefore it will show the content of the Login Page
    #to make it better, errors like in register.rb should be used
    expect(page).to have_content "Username or password is invalid"
    clear_database
  end

  it "will not login when user is suspended" do
    test_register_user
    DB[:users].where(userID: 1).update(suspended: 1) 
    test_login
    #When you submit the form with incorrect details it loads again the Login Page
    #therefore it will show the content of the Login Page
    #to make it better, errors like in register.rb should be used
    expect(page).to have_content "This user has been suspended,"
    clear_database
  end
end