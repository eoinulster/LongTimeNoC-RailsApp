class RemoveNoteFromEvent < ActiveRecord::Migration[5.2]
    def change
      remove_column :events, :note, :text
    end
end
