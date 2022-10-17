require_relative "../spec_helper"

describe "the admin page" do
  it "will approve a post in admin_posts" do
    #User has to be registered in order to do this testing
    create_post
    create_admin
    test_login
    visit "/admin_posts"
    
    click_button "Approve"
    visit "/home"

    expect(page).to have_content "Post Title"
    clear_database
  end

  it "will reject a post in admin_posts" do
    #User has to be registered in order to do this testing
    create_post
    create_admin
    test_login
    visit "/admin_posts"
    
    click_button "Reject"
    visit "/home"

    expect(page).not_to have_content "Post Title"
    clear_database
  end

  it "will hide a post" do
    hide_post

    visit "/home"
    expect(page).not_to have_content "Post Title"
    clear_database    
  end

  it "will not allow you to enter the page if you don't have authorization" do
    visit "/admin_posts"

    expect(page).to have_content "You do not have authorization to view this page"
  end
end