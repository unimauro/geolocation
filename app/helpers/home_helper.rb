module HomeHelper
  def format_status(status)
    status.nil? ? 'Status: Unknown' : "Status: #{status}"
  end

  def display_error_message(error_message)
    "Error: #{error_message}"
  end
end