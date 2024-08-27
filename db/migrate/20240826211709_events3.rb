class Events3 < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :user_id, :integer
    add_foreign_key :events, :users, :user_id

  end
end
