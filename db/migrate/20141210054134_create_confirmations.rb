class CreateConfirmations < ActiveRecord::Migration
  def change
    create_table :confirmations do |t|
      t.string :locate
      t.text :locate_desc
      t.string :safely
      t.text :safely_desc
      t.boolean :contacted, :default => false, :null => false
      t.integer :disaster_id, :null => false
      t.integer :user_id, :null => false

      t.timestamps
    end
  end
end
