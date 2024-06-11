require 'rails_helper'

RSpec.describe GeolocationValue, type: :model do
  describe "validations" do
    before do
      GeolocationValue.create(ip: "192.168.1.1", web: "example.com")
    end

    it "is valid with valid attributes" do
      geolocation_value = GeolocationValue.new(ip: "192.168.1.2", web: "example.org")
      expect(geolocation_value).to be_valid
    end

    it "is not valid without an IP or URL" do
      geolocation_value = GeolocationValue.new(ip: nil, web: nil)
      expect(geolocation_value).not_to be_valid
      expect(geolocation_value.errors[:ip]).to include("can't be blank")
      expect(geolocation_value.errors[:web]).to include("can't be blank")
    end

    it "is not valid with a duplicate IP or URL" do
      geolocation_value = GeolocationValue.new(ip: "192.168.1.1", web: "example.com")
      expect(geolocation_value).not_to be_valid
      expect(geolocation_value.errors[:ip]).to include("has already been taken")
      expect(geolocation_value.errors[:web]).to include("has already been taken")
    end
  end
end