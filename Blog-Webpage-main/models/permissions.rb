def getUserType() # Returns 0 if guest/not signed in, 1 if viewer, 2 if moderator, 3 if administrator
    attemptUser = DB[:users].where(userID: session[:userID])
    attemptUser.each do |user|
        if user[:userType] == "ADMINISTRATOR"
            return 4
        elsif user[:userType] == "MODERATOR"
            return 3
        elsif user[:userType] == "VIEWER"
            return 2
        elsif user[:userType] == "REPORTER"
            return 1
        elsif user[:userType] == "GUEST"
            return 0
        end
    end
    return 0
end

def getFirstName() # Returns 0 if guest/not signed in, 1 if viewer, 2 if moderator, 3 if administrator
    attemptUser = DB[:users].where(userID: session[:userID])
    attemptUser.each do |user|
        return user[:firstName]
    end
    return "Guest"
end

# Returns the username of the user with specific userID
def getUserName()
  attemptUser = DB[:users].where(userID: session[:userID])
  attemptUser.each do |user|
      return user[:username]
  end
end
