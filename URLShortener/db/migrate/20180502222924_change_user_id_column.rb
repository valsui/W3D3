class ChangeUserIdColumn < ActiveRecord::Migration[5.1]
  def change
    change_column_null :shortened_urls, :user_id, false
  end
end
