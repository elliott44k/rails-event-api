class Events < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :events, :users, :user_id
    change_column_default :events, :start_time, -> {'CURRENT_TIMESTAMP'}
    change_column_default(:events, :end_time, -> {'CURRENT_TIMESTAMP'})
    change_column_default(:events, :created_at, -> {'CURRENT_TIMESTAMP'})
    change_column_default(:events, :updated_at, -> {'CURRENT_TIMESTAMP'})
    change_column_default(:users, :created_at, -> {'CURRENT_TIMESTAMP'})
    change_column_default(:users, :updated_at, -> {'CURRENT_TIMESTAMP'})
  end
end
