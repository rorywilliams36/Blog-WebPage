get "/profile" do

  @name = getFirstName()
  requestedUserID = session[:userID] # Replace set number with userID

  hasLoggedIn = session[:hasLoggedOn]  # replace true/false with function to check 
  puts "Profile Requested for UserID #{requestedUserID}, Allowed Access: #{hasLoggedIn}"
  # check that the ID above has logged in
  @users = DB[:users].where(userID: requestedUserID)

  # if above is true then display successful login page else display fail
  if hasLoggedIn
    erb :profile
  else
    erb :profile_fail
  end
end
