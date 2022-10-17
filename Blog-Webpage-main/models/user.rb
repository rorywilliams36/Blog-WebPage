require "logger"
require "sequel"

class User < Sequel::Model
  def name
    "#{firstName} #{surname}"
  end
end

