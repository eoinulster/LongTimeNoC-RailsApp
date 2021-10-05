class CreateJoinTableClosecontactsEvents < ActiveRecord::Migration[5.2]
  def change
    create_join_table :closecontacts, :events,  {:id => true} do |t|
      t.index [:closecontact_id, :event_id]
      t.index [:event_id, :closecontact_id]
    end
  end
end
