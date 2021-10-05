class CreateClosecontacts < ActiveRecord::Migration[5.2]
  def change
    create_table :closecontacts do |t|
      t.string :firstname, null: false
      t.string :secondname, null: false
      t.string :telephone
      t.string :email
      t.boolean :regular, null: false, default: false

      t.timestamps
    end
  end
end
