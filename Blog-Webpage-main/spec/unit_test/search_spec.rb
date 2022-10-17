require_relative "../spec_helper"

describe "Search" do
    it "lists all the posts belong to the organization" do
        create_admin
        test_post_blog
        visit "/home"
        fill_in "filter_org", with: "Post Organization"
        click_button "Search"
        expect(page).to have_content "Post Title"
        clear_database
    end

    it "lists all the posts made by users with the usertype" do
        create_post
        create_admin
        test_login
        visit "/admin_posts"
        get "/admin_posts", "filter_type" => "Viewer"      
        click_button "Search"
        expect(page).to have_content "Post Title"
        clear_database
    end
        
    it "lists all the posts belong to the category" do
        create_post
        create_admin
        test_login
        visit "/admin_posts"
        get "/admin_posts", "filter_table" => "Approve/Reject"      
        click_button "Search"
        expect(page).to have_content "Post Title"
        clear_database
    end

end