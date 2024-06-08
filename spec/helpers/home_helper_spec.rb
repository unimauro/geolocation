require 'rails_helper'

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

