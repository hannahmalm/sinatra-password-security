class User < ActiveRecord::Base
    #this macro has_secure_password is being called like a normal ruby method
    #it works in conjunction with a gem called bcrypt
    #this will authenticate a user
    #1. takes a string as an agrument 
    #2. turns a string into a salted, hash version
    #3. Compares salted, hash version with users stored salted hashed password
    #4. If the versions match, authenticte will return the user if not it returns false
	has_secure_password 
end 