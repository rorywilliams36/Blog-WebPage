require "logger"
require "sequel"
require "sqlite3"

get "/admin" do
  @name = getFirstName()
  if getUserType() >= 3
    erb :admin
  else
    erb :admin_fail
  end
end

get "/admin_posts" do
  @name = getFirstName()
  if getUserType() >= 3
    @posts = DB[:posts]
    erb :admin_posts
  else
    erb :admin_fail
  end
end

get "/admin_users" do
  @name = getFirstName()
  if getUserType() == 4
    @users = DB[:users]
    erb :admin_users
  else
    erb :admin_fail
  end
end

#When a post is approved this post method is called
post '/approve_post' do
  @name = getFirstName()
  @postID = params[:post_id]

  #Searches for the dataset with a matching id and changes the approved value to true
  DB[:posts].where(id:@postID).update(approved: 1)

  erb :admin_posts
end

#When a post is rejected this post method is called
post '/reject_post' do
  @name = getFirstName()
  @postID = params[:post_id]

  #Searches for the dataset with a matching id and deletes the post from the database
  DB[:posts].where(id:@postID).delete

  erb :admin_posts
end