class AddAttendeds < ActiveRecord::Migration[5.2]
    def change
        create_table :attendeds, :id => false do |t|

         t.integer :event_id
         t.integer :closecontact_id

         t.timestamps
        end
    end
end
