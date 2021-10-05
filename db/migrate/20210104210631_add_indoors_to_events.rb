class AddIndoorsToEvents < ActiveRecord::Migration[5.2]
  def change
      add_column :events, :indoors, :boolean
  end
end
