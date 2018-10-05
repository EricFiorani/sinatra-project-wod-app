class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_digest #integrates with has_secure_password in order to have a password that stores an encrypted version
    end
  end
end
