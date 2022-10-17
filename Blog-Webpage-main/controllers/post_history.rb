get "/post_history" do  
  @name = getFirstName()
  @post = Post.all

  requestedUserID = params[:id]
  @users = DB[:users].where(userID: requestedUserID)

  erb :post_history
end