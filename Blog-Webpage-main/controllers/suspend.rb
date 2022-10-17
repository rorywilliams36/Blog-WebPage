post "/suspenduser" do
    @name = getFirstName()
    suspend(params[:suspendID])
    @users = User.all
    erb :admin_users
end

def suspend(usrID)
    targetUser = User.first(userID: usrID)
    isSuspended = targetUser[:suspended]
    puts "User #{targetUser[:firstName]} is being suspended"
    if isSuspended == 0
        # code to change value to 1
        targetUser[:suspended] = 1
        targetUser.save_changes
    else
        # code to change value to 0
        targetUser[:suspended] = 0
        targetUser.save_changes
    end
end