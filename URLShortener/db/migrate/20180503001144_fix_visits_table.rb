class FixVisitsTable < ActiveRecord::Migration[5.1]
  def change
    remove_index :visits, [:user_id, :shortened_url_id]
    add_index :visits, :user_id
    remove_column :visits, :shortened_url_id, :string
    add_column :visits, :shortened_url_id, :integer
  end
end
