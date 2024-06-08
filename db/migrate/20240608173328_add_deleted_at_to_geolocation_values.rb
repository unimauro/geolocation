class AddDeletedAtToGeolocationValues < ActiveRecord::Migration[7.1]
  def change
    add_column :geolocation_values, :deleted_at, :datetime
    add_index :geolocation_values, :deleted_at
  end
end
