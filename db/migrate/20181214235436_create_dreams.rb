class CreateDreams < ActiveRecord::Migration
  def change
    create_table :dreams do |t|
      t.text :description
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
