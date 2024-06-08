class CreateGeolocationValues < ActiveRecord::Migration[7.1]
  def change
    create_table :geolocation_values do |t|
      t.string :ip
      t.string :url
      t.float :latitude
      t.float :longitude
      t.string :city
      t.string :country

      t.timestamps
    end
  end
end
