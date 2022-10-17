get "/adminedit" do
    if getUserType >= 3
        @targetUser = User.first(userID: params[:id])
        erb :"profileedit/specific_profile"
    else
        erb :admin_fail
    end
end

# Edit Name (TITLE, FIRSTNAME & SURNAME)
get "/edit/name" do
    @name = getFirstName()
    @message = "Fill in form below to make changes!"
    @targetUser = User.first(userID: params[:id])
    erb :"profileedit/update_name"
end

post "/edit/name" do
    @name = getFirstName()
    @targetUser = User.first(userID: params[:id])
    @targetUser[:title] = params[:updateTitle]
    @targetUser[:firstName] = params[:updateFirstName]
    @targetUser[:surname] = params[:updateSurname]
    @targetUser.save_changes
    @message = "Changes made successfully! Head back to <a href='/profile'>profile</a>?"
    erb :"profileedit/update_name"
end

# Edit DoB
get "/edit/dateOfBirth" do # /edit/dateOfBirth?id=X where X equals an userID
    @name = getFirstName()
    @message = "Fill in form below to make changes! DD-MM-YYYY"
    # Grab the User object for the specified ID in the url
    @targetUser = User.first(userID: params[:id])
    erb :"profileedit/update_dob"
end

post "/edit/dateOfBirth" do
    @name = getFirstName()
    @targetUser = User.first(userID: params[:id])
    @targetUser[:dateOfBirth] = params[:dob]
    @targetUser.save_changes
    @message = "Changes made successfully! Head back to <a href='/profile'><b>profile</b></a>?"
    erb :"profileedit/update_dob"
end

# Phone Number
get "/edit/phoneNumber" do
    @name = getFirstName()
    @message = "Fill in form below to make changes!"
    @targetUser = User.first(userID: params[:id])
    erb :"profileedit/update_phonenum"
end

post "/edit/phoneNumber" do
    @name = getFirstName()
    @targetUser = User.first(userID: params[:id])
    @targetUser[:phoneNumber] = params[:phoneNumber]
    @targetUser.save_changes
    @message = "Changes made successfully! Head back to <a href='/profile'>profile</a>?"
    erb :"profileedit/update_phonenum"
end

# Email
get "/edit/email" do
    @name = getFirstName()
    @message = "Fill in form below to make changes!"
    @targetUser = User.first(userID: params[:id])
    erb :"profileedit/update_email"
end

post "/edit/email" do
    @name = getFirstName()
    @targetUser = User.first(userID: params[:id])
    @targetUser[:email] = params[:email]
    @targetUser.save_changes
    @message = "Changes made successfully! Head back to <a href='/profile'>profile</a>?"
    erb :"profileedit/update_email"
end

# University
get "/edit/university" do
    @name = getFirstName()
    @message = "Fill in form below to make changes!"
    @targetUser = User.first(userID: params[:id])
    erb :"profileedit/update_university"
end

post "/edit/university" do
    @name = getFirstName()
    @targetUser = User.first(userID: params[:id])
    @targetUser[:university] = params[:university]
    @targetUser.save_changes
    @message = "Changes made successfully! Head back to <a href='/profile'>profile</a>?"
    erb :"profileedit/update_university"
end

get "/edit/userType" do
    if getUserType >= 3
        @name = getFirstName()
        @message = "Select the UserType"
        @targetUser = User.first(userID: params[:id])
        erb :"profileedit/update_userType"
    else 
        erb :admin_fail
    end
end

post "/edit/userType" do
    @name = getFirstName()
    @targetUser = User.first(userID: params[:id])
    @targetUser[:userType] = params[:userType].upcase
    @targetUser.save_changes
    @message = "Changes made successfully! Head back to <a href='/profile'>profile</a>?"
    erb :"profileedit/update_userType"
end