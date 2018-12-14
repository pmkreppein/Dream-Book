class CreateKarma < ActiveRecord::Migration
  def change
    create_table :karmas do |t|
      t.integer :user_id
      t.integer :dream_id
    end
  end
end
