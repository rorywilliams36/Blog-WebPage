require_relative "../spec_helper"

describe "the edit pages" do

  it "allow the editing of a post" do             
    test_post_blog
    visit "/edit_post?id=1"
    expect(page).to have_content "Edit Post Here:"
    clear_database
  end

  it "allow a post to be edited" do
    test_post_blog
    visit "/edit_post?id=1"
    fill_in "post_content", with: "New Content"
    click_button "Save"
    
    visit "/post?id=1"
    expect(page).to have_content "New Content"
    expect(page).to have_content "Post Organization"    
    clear_database
  end  

  it "edit the profile Full Name" do
    test_register_user
    test_login

    visit "edit/name?id=1"
    fill_in "updateTitle", with: "New Title"
    fill_in "updateFirstName", with: "New FirstName"
    fill_in "updateSurname", with:"New Surname"
    click_button "Make Changes"

    visit "/profile"
    expect(page).to have_content "New Title"
    expect(page).to have_content "New FirstName"
    expect(page).to have_content "New Surname"
    clear_database
  end

  it "edit the profile Date of Birth" do
    test_register_user
    test_login

    visit "edit/dateOfBirth?id=1"
    fill_in "dob", with: "22-07-1992"
    click_button "Make Changes"

    visit "/profile"
    expect(page).to have_content "22-07-1992"
    clear_database
  end

  it "edit the profile University" do
    test_register_user
    test_login

    visit "edit/university?id=1"
    fill_in "university", with: "New University"
    click_button "Make Changes"

    visit "/profile"
    expect(page).to have_content "New University"
    clear_database
  end

  
  it "edit the profile Phone Number" do
    test_register_user
    test_login

    visit "edit/phoneNumber?id=1"
    fill_in "phoneNumber", with: "1010101"
    click_button "Make Changes"

    visit "/profile"
    expect(page).to have_content "1010101"
    clear_database

  end

  it "edit the profile Email" do
    test_register_user
    test_login

    visit "edit/email?id=1"
    fill_in "email", with: "newEmail@email.com"
    click_button "Make Changes"

    visit "/profile"
    expect(page).to have_content "newEmail@email.com"
    clear_database

  end
end