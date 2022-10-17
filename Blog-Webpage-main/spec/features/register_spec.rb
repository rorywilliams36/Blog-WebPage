require_relative "../spec_helper"

describe "the register page" do
  it "will register a user when all details are entered" do
    test_register_user
    expect(page).to have_content "Successful register!"
  end

  it "will not register user when username is already being used" do 
    visit "/register"
    fill_in "username", with: "test"
    fill_in "title", with: "test"
    fill_in "firstname", with: "test"
    fill_in "surname", with: "test"
    fill_in "password", with: "Testing1@"
    fill_in "confirm_password", with: "Testing1@"
    fill_in "email", with: "test@testing.com"
    fill_in "phonenumber", with: "999999999"
    fill_in "dateofbirth", with: "1999-07-22"
    fill_in "university", with: "University of Test"
    click_button "Sign Up"
    expect(page).to have_content "Username is either empty or already taken"

    clear_database
  end

  it "will not register user when password is invalid" do
    visit "/register"
    fill_in "username", with: "test"
    fill_in "title", with: "test"
    fill_in "firstname", with: "test"
    fill_in "surname", with: "test"
    fill_in "password", with: "testing123"
    fill_in "confirm_password", with: "testing123"
    fill_in "email", with: "test@gmail.com"
    fill_in "phonenumber", with: "999999999"
    fill_in "dateofbirth", with: "1999-07-22"
    fill_in "university", with: "University of Test"
    click_button "Sign Up"

    expect(page).to have_content "Password invalid"

    clear_database
  end

  it "will not register user when confirm_password does not match with password" do
    visit "/register"
    fill_in "username", with: "test"
    fill_in "title", with: "test"
    fill_in "firstname", with: "test"
    fill_in "surname", with: "test"
    fill_in "password", with: "Testing1@"
    fill_in "confirm_password", with: "Testing2£"
    fill_in "email", with: "test@gmail.com"
    fill_in "phonenumber", with: "999999999"
    fill_in "dateofbirth", with: "1999-07-22"
    fill_in "university", with: "University of Test"
    click_button "Sign Up"

    expect(page).to have_content "Password doesn't match Confirm Password"
      
    clear_database
  end

  it "will not register user when phonenumber is already taken" do
    test_register_user

    visit "/register"
    fill_in "username", with: "test2"
    fill_in "title", with: "test2"
    fill_in "firstname", with: "test"
    fill_in "surname", with: "test"
    fill_in "password", with: "Testing1@"
    fill_in "confirm_password", with: "Testing1@"
    fill_in "email", with: "test2@gmail.com"
    fill_in "phonenumber", with: "888888888"
    fill_in "dateofbirth", with: "1999-07-22"
    fill_in "university", with: "University of Test"
    click_button "Sign Up"

    expect(page).to have_content "Phone number is either empty or already taken"
    
    clear_database
  end

  it "will not register user when email is already taken" do
    test_register_user

    visit "/register"
    fill_in "username", with: "test2"
    fill_in "title", with: "test2"
    fill_in "firstname", with: "test"
    fill_in "surname", with: "test"
    fill_in "password", with: "Testing1@"
    fill_in "confirm_password", with: "Testing1@"
    fill_in "email", with: "test@testing.com"
    fill_in "phonenumber", with: "999999999"
    fill_in "dateofbirth", with: "1999-07-22"
    fill_in "university", with: "University of Test"
    click_button "Sign Up"

    expect(page).to have_content "Email is either empty or already taken"
    
    clear_database
  end

  it "will not register user when age invalid less than 18 yrs" do
    test_register_user

    visit "/register"
    fill_in "username", with: "test2"
    fill_in "title", with: "test2"
    fill_in "firstname", with: "test"
    fill_in "surname", with: "test"
    fill_in "password", with: "Testing1@"
    fill_in "confirm_password", with: "Testing1@"
    fill_in "email", with: "test2@gmail.com"
    fill_in "phonenumber", with: "999999999"
    fill_in "dateofbirth", with: "2009-07-22"
    fill_in "university", with: "University of Test"
    click_button "Sign Up"

    expect(page).to have_content "Age is invalid"
    
    clear_database
  end

  it "will not register user when age invalid using inappropriate value" do
    test_register_user

    visit "/register"
    fill_in "username", with: "test2"
    fill_in "title", with: "test2"
    fill_in "firstname", with: "test"
    fill_in "surname", with: "test"
    fill_in "password", with: "Testing1@"
    fill_in "confirm_password", with: "Testing1@"
    fill_in "email", with: "test2@gmail.com"
    fill_in "phonenumber", with: "999999999"
    fill_in "dateofbirth", with: "1066-07-22"
    fill_in "university", with: "University of Test"
    click_button "Sign Up"

    expect(page).to have_content "Age is invalid"
    
    clear_database
  end
end