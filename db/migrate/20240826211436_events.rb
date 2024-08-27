class Events < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :events, :users
  end
end
