class CreateUsers < ActiveRecord::Migration[5.1]
  def up
    create_table :users do |t|
      t.string :username 
      t.string :password_digest
      #BCrypt will store a salted, hashed version of our users' passwords in our database in a column called password_digest. 
    end
  end 
  
  def down
    drop_table :users
  end
end
