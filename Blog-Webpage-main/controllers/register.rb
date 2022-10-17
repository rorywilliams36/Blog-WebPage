require "logger"
require "sequel"

#!/usr/bin/ruby -w

# TODO: Add password encryption and use post method
#       Age and university checker
#       May be able to reduce runtime by using 1 for loop for checking functions
#       May also make the params variables to reduce line lengths

get "/register" do
  @Users = User.all
  valid = true

  @submit_msg = nil
  @user_error = nil
  @email_error = nil
  @phone_error = nil
  @password_error = nil
  @confirm_error = nil

  # Chekcs if page is submitted by checking if any inputs have been filled
  @submitted = !params[:username].nil? || !params[:password].nil? || !params[:confirm_password].nil? || !params[:email].nil? || !params[:phonenumber].nil?
  
  # If form is submitted calls other functions to check input are correct
  # Most functions loop through db checking if any credentials already exist
  # Fucntions return false if its invalid
  # The if statements displays the relevant error and resets the page
  if @submitted
    if (!username_check(params[:username]))
      @user_error = "Username is either empty or already taken"
      valid = false
    end

    if (!email_check(params[:email]))
      @email_error = "Email is either empty or already taken"
      valid = false
    end

    if (!phone_check(params[:phonenumber]))
      @phone_error = "Phone number is either empty or already taken"
      valid = false
    end

    if (!validPassword(params[:password]))
      @password_error = "Password invalid"
      valid = false
    end

    if (!confirm_password_check(params[:password], params[:confirm_password]))
      @confirm_error = "Password doesn't match Confirm Password"
      valid = false
    end

    if (!age_check(params[:dateofbirth]))
      @age_error = "Age is invalid"
      valid = false
    end

    # If there are no errors inputs are added to the database
    if valid
      DB[:users] << {username:params[:username], firstName:params[:firstname], surname:params[:surname],
                    dateOfBirth:params[:dateofbirth], university:params[:university], userType: "VIEWER",
                    password:params[:password], phoneNumber:params[:phonenumber], email:params[:email], title:params[:title]}
      @submit_msg = "Successful register!"
      puts "Successful register"
    else
      @submit_msg = "Correct the errors below before submitting"
    end
  end

  erb :register
end

# Checks password meets requirements
def validPassword(password)
  symbols = ["!", '"', "#", "$", "%", "&", "'", "(", ")", "*", "+", ",", "-", ".", "/", ":",
              ";", "<", "=", ">", "?", "@", "[", "/", "]", "^", "_", "`", "{", "|", "}", "~"]
  numbers= ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
  counts = [0, 0, 0]

  # Makes array where each character in password is an element
  # Loops through each character checking if its symbol, number or uppercase using the arrays above
  # If so adds to counts array [Symbol count, number count, uppercase count]
  passArray = password.split("")
  passArray.each do |c|
    if (symbols.include?(c.to_s))
      counts[0] += 1
    elsif (numbers.include?(c.to_s))
      counts[1] += 1
    elsif (c.to_s == c.to_s.upcase)
      counts[2] += 1
    end
  end

  # If there is an uppercase, symbol and a number password is valid
  if (counts[0] > 0 && counts[1] > 0 && counts[2] > 0)
    puts "Valid Password"
    return true
  end

  puts "Invalid Password"
  return false
end

# Checks if username already exists
def username_check(username)
  @Users.each do |user|
    if (user.username.to_s.chomp == username.to_s.chomp)
        puts "Username taken"
      return false
    end
  end
  puts "Username valid"
  return true
end

# checks if password matches with confirm password
def confirm_password_check(password, confirmPassword)
  if (password.to_s.chomp == confirmPassword.to_s.chomp)
    puts "Pass match"
    return true
  end
  puts "Pass don't match"
  return false
end

# Checks if email already exists
def email_check(email)
  @Users.each do |user|
    if (user.email.to_s.chomp == email.to_s.chomp)
      puts "Email taken"
      return false
    end
  end
  puts "Email valid"
  return true
end

# Checks if phone number already exists
def phone_check(phone)
  @Users.each do |user|
    if (user.phoneNumber == phone)
      puts "Phone taken"
      return false
    end
  end
  puts "Phone valid"
  return true
end

# Checks dob is valid
def age_check(age)
  # Gets current date
  time = Time.new

  # Converts dates into arrays [year, month, day]
  age_array = age.split("-")
  time_array = time.strftime("%Y-%m-%d").split("-")

  # Checks user is older than 18 and the inputted year is appropiate
  if ((age_array[0].to_i < time_array[0].to_i-18) && (age_array[0].to_i > time_array[0].to_i-125))
      return true
  end

  # Checks user is older than 18 by validating the months
  if (age_array[0].to_i == time_array[0].to_i-18)
    if (age_array[1].to_i > time_array[1].to_i)
      return true
    end 
  end
  return false
end