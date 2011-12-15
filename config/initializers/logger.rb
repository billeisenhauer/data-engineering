require 'log_formatter'

Lschallenge::Application.configure do
  config.logger = Logger.new(config.paths['log'].first)
  config.logger.formatter = LogFormatter.new
  config.logger.level = Logger::DEBUG
end