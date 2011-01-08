if "development" == Rails.env
  Paperclip.options[:command_path] = "/usr/local/bin"
end