require "logger"
require "sequel"

class Post < Sequel::Model
    def load(params)
        self.title = params.fetch("title", "").strip
        self.organization = params.fetch("organization", "").strip
        self.content = params.fetch("content", "").strip
        self.userID = params.fetch("userID", "").strip
    end
    
    def validate
        errors.add("title", "cannot be empty") if !title || title.empty?
        errors.add("organization", "cannot be empty") if !organization || organization.empty?
        errors.add("content", "cannot be empty") if !content || content.empty?
    end

    def self.exist?(id)
        return false if id.nil?
        return false if Post[id].nil?
        true
    end

end