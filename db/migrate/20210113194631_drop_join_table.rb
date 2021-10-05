class DropJoinTable < ActiveRecord::Migration[5.2]
    def up
      drop_table :closecontacts_events
    end

    def down
      raise ActiveRecord::IrreversibleMigration
    end
end
