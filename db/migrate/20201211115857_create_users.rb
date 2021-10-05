class CreateUsers < ActiveRecord::Migration[5.2]
    def change
      create_table :users do |t|
        t.string :email, null: false
        t.string :password_digest, null: false, default: "CN-=+9nG5A"
        t.string :session_token, null: false
        t.boolean :activated, null: false, default: true
        t.string :activation_token, null: false, default: "activate"

        t.timestamps
      end

      add_index :users, :email
      add_index :users, :session_token, unique: true
      add_index :users, :activation_token
    end
end
