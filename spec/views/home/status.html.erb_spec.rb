require 'rails_helper'

RSpec.describe "home/status.html.erb", type: :view do
  it "renders the status page" do
    render
    expect(rendered).to match /Status Page/
  end
end
