require "sinatra"
require "sinatra/reloader"
require "require_all"

enable :sessions
set :session_secret, "$g]Rd2M/WbJ`~~<GZWdH@Fm'ESk2_gckCtLJJkySYG"

require_rel "db/db", "models", "controllers"

get "/" do
  session[:session_name] = nil
  session[:userID] = 0
  session[:hasLoggedOn] = false

  @name = getFirstName()
  @page_name = "Home"
  erb :home
end

error 404 do
  erb :error
end