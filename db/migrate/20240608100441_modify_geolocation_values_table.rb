class ModifyGeolocationValuesTable < ActiveRecord::Migration[7.1]
  def change
    remove_column :geolocation_values, :url, :string
    remove_column :geolocation_values, :latitude, :float
    remove_column :geolocation_values, :longitude, :float
    remove_column :geolocation_values, :city, :string
    remove_column :geolocation_values, :country, :string
    add_column :geolocation_values, :data, :jsonb
  end
end
