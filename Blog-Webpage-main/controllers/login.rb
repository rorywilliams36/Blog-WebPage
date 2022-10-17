require "logger"
require "sequel"
require "sqlite3"

get "/login" do
    @name = getFirstName()
    puts "usertype = #{getUserType}"
    if getUserType() == 0
        @page_name = "Login"
        erb :login
    else
        erb :login_fail
    end
  end

# Calls function when user submits name and password
# Uses array from validate_login 
post "/login_input" do
    @name = getFirstName()
    loginValues = validate_Login(@params[:username], @params[:password])
    session[:hasLoggedOn] = loginValues[0]
    session[:userID] = loginValues[1]

    @submitted = true
    @msg = nil

    # if true go to next page
    if(session[:hasLoggedOn] == true)
        user = User.first(userID: session[:userID])
        if user.suspended == 1
            puts "Suspended user attempted to log in!"
            session[:hasLoggedOn] = false
            session[:userID] = 0
            erb :suspended
        else
            #session variables that store the username and if its logged in
            session[:session_name] = @params[:username]

            session[:hasLoggedOn] = true
            @name = getFirstName()
            erb :home
        end

        
    else
        puts "Unsuccessful login"
        @msg = "Username or password is invalid"
        session[:session_name] = nil
        session[:hasLoggedOn] = false
        
        erb :login
    end
end

get "/logout" do 
    session[:hasLoggedOn] = false
    session[:userID] = 0
    
    session[:session_name] = nil

    erb :login
end

# Checks if password and username are valid
# Compares inputs with values in the db users table
# Returns array containing userID and login boolean
def validate_Login(username, password)
    # Loops through every user in db
    @Users = User.all
    login = false
    id = 0
    @Users.each do |user|
        if (user.username.to_s.chomp == username.to_s.chomp && user.password.to_s.chomp == password.to_s.chomp)
            id = user.userID
            login = true
            break

        else
            login = false
        end
    end

    return login, id
end