class AddColumnsToEvents < ActiveRecord::Migration[5.2]
    def change
        change_table :events do |t|
            t.string :title
            t.string :location
            t.datetime :date
            t.integer :duration
        end
    end
end
