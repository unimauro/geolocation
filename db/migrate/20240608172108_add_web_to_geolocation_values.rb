class AddWebToGeolocationValues < ActiveRecord::Migration[7.1]
  def change
    add_column :geolocation_values, :web, :text
  end
end
