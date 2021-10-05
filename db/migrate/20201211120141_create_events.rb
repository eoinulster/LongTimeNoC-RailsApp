class CreateEvents < ActiveRecord::Migration[5.2]
    def change
      create_table :events do |t|
        t.integer :user_id, null: false
        t.text :note

        t.timestamps
      end
  end
end
