class DropAttendedsTable < ActiveRecord::Migration[5.2]
    def up
      drop_table :attendeds
    end

    def down
      raise ActiveRecord::IrreversibleMigration
    end
end
