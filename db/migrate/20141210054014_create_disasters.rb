class CreateDisasters < ActiveRecord::Migration
  def change
    create_table :disasters do |t|
      t.string :name, :null => false
      t.text :description

      t.timestamps
    end
  end
end
