require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the HomeHelper. For example:
#
# describe HomeHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe HomeHelper, type: :helper do
  describe '#format_status' do
    it 'returns formatted status string' do
      status = 'OK'
      expect(helper.format_status(status)).to eq('Status: OK')
    end

    it 'handles nil status' do
      expect(helper.format_status(nil)).to eq('Status: Unknown')
    end
  end

  describe '#display_error_message' do
    it 'returns formatted error message' do
      error_message = 'Resource not found'
      expect(helper.display_error_message(error_message)).to eq('Error: Resource not found')
    end
  end
end

