require_relative "../spec_helper"

describe "the blog page" do
  it "will filter by organization if specified" do
    #Creates a post and logs in into an admin account
    create_post
    create_admin
    test_login
    visit "/admin_posts"
    
    #Before the post appears, it has to be approved
    click_button "Approve"
    visit "/home"

    #Filters the post organization
    fill_in "filter_org", with: "Post Organization"
    click_button "Search"
    
    expect(page).to have_content "Post Organization"
    clear_database
  end
end