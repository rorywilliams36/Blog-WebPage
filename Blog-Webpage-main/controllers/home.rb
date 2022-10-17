ERB::Util

get "/home" do  
    @name = getFirstName()
    @post = Post.all
    
    erb :home
end

post "/filter_org" do 
  @filter_posts = params[:filter_org]

  erb :home
end

post "/reset_filters" do
  erb :home
end