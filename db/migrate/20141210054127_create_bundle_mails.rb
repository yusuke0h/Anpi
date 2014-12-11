class CreateBundleMails < ActiveRecord::Migration
  def change
    create_table :bundle_mails do |t|
      t.string :title, :null => false
      t.text :body
      t.integer :disaster_id, :null => false

      t.timestamps
    end
  end
end
