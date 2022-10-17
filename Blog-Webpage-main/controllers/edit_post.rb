require "sequel"
require "sqlite3"

get "/edit_post" do
    id = params[:id]
    @post = Post[id]
    erb :edit_post
  end 
  
post "/edit_posts" do
    id = params[:id]

    #Updates the data in the database to the new parameters
    if Post.exist?(id)      
      DB[:posts].where(id: id).update(title: params[:post_title]) 
      DB[:posts].where(id: id).update(organization: params[:post_organization]) 
      DB[:posts].where(id: id).update(content: params[:post_content]) 
    end

    erb :home
end
  
 
    