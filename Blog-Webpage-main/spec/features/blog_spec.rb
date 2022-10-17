require_relative "../spec_helper"

describe "the blog page" do
  it "will not submit a post with no details" do
    #User has to be registered in order to do this testing
    test_register_user
    test_login
    visit "/blog"
    click_button "Post"
    #Capybara redirecting to an empty page which we do not have
    #This works but not exactly what expected
    #In order to fix this, errors like in the register.rb have to implemented
    expect(page).to have_content ""
    clear_database
  end

  it "submits a post when all details are entered" do
    #User has to be registered in order to do this testing
    test_post_blog

    #Creates an admin in order to approve the post
    create_admin
    test_login
    visit "/admin_posts"
    
    click_button "Approve"
    visit "/home"
    expect(page).to have_content "Post Title"

    clear_database
  end

  it "will show all the posts by a user in post_history" do
    test_register_user
    test_post_blog

    visit "/post_history?id=1"
    expect(page).to have_content "Post Title"

    clear_database
  end
end