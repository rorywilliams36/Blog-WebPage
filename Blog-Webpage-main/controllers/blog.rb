require "logger"
require "sequel"
require "sqlite3"

get "/blog" do
  @name = getFirstName()
  @page_name = "Blog"
  erb :blog
end

get "/blog_input" do
    @name = getFirstName()
    @post = Post.new
    erb :blog
end

post "/blog_input" do
    @name = getFirstName()
    #This will be changed to detect the current user
    @currentUser = session[:session_name]
    @logged = session[:hasLoggedOn]

    approved = 0

    @Users = User.all

    #Only logged in users can post, if its not logged in it will send you to login.erb
    if @logged == true
        approved = checkUserType(@currentUser, @logged)
        
        @title = params[:post_title]
        @organization = params[:post_organization]
        @content  = params[:post_content]
        @userID = @currentUser
        attemptUser = DB[:users].where(userID: session[:userID])
        attemptUser.each do |user|
          @userType = user[:userType]
        end
        @suspended = 0
        @approved = approved
        
        #Adds all the values to the posts table in the database
        DB[:posts] << { userID:@userID, userType:@userType, title:@title, organization:@organization, content:@content, approved:@approved, suspended:@suspended }

        erb :home
    else
        approved = checkUserType(@currentUser, @logged)
        
        @title = params[:post_title]
        @organization = params[:post_organization]
        @content  = params[:post_content]
        @userID = "Unknown"
        @userType = "GUEST"
        @approved = approved
        @suspended = 0
        
        #Adds all the values to the posts table in the database
        DB[:posts] << { userID:@userID, userType:@userType, title:@title, organization:@organization, content:@content, approved:@approved, suspended:@suspended }

        erb :home
    end
end

#Checks the userType in order to set a value to approved
def checkUserType(username, logged)

    #Uses the select method from SQL in order to search for the user in the Users table in the database
    if logged == true
        current_userType = DB[:users].select(:userType).where(username:username).first[:userType]
    else
        current_userType = nil
    end

    #If the user is a guest/viewer/reporter it sets approved to false
    if current_userType == nil
        approved = 0
    elsif current_userType.downcase.chomp == "viewer"
        approved = 0
    elsif current_userType.downcase.chomp == "reporter"
        approved = 0
    else
        approved = 1
    end 

    return approved
end