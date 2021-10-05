class AddUserToClosecontact < ActiveRecord::Migration[5.2]
    def self.up
      add_column :closecontacts, :user_id, :integer
      change_column :closecontacts, :user_id, :integer, :null => false
    end

    def self.down
        remove_column :closecontacts, :user_id
    end
end
