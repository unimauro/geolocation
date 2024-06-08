require 'rails_helper'

RSpec.describe GeolocationValue, type: :model do
  describe "validations" do
    it "is valid with valid attributes" do
      geolocation_value = GeolocationValue.new(ip: "192.168.1.1", url: "example.com")
      expect(geolocation_value).to be_valid
    end

    it "is not valid without an IP or URL" do
      geolocation_value = GeolocationValue.new(ip: nil, url: nil)
      expect(geolocation_value).not_to be_valid
    end

    it "is not valid with a duplicate IP or URL" do
      GeolocationValue.create(ip: "192.168.1.1", url: "example.com")
      geolocation_value = GeolocationValue.new(ip: "192.168.1.1", url: "example.com")
      expect(geolocation_value).not_to be_valid
    end
  end

  describe "associations" do
    it "has many users" do
      association = described_class.reflect_on_association(:users)
      expect(association.macro).to eq :has_many
    end
  end
end
