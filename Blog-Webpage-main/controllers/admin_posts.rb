post "/filter_posts" do 
  @filter_userType = params[:filter_type].upcase
  @filter_table = params[:filter_table]

  erb :admin_posts
end