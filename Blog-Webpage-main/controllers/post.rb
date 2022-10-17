ERB::Util

get "/post" do  
  @name = getFirstName()
  @posts = DB[:posts].where(id: params[:id])
                   
  erb :post
end

#Post form that hides posts
post "/hide_post" do

  @postID = params[:post_id]

  #Searches for the dataset with a matching id and changes the approved value to true
  DB[:posts].where(id:@postID).update(suspended: 1)

  erb :home

end

#Post form that recovers hidden posts
post "/recover_post" do

  @postID = params[:post_id]

  #Searches for the dataset with a matching id and changes the approved value to false
  DB[:posts].where(id:@postID).update(suspended: 0)

  erb :home

end