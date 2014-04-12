ENV['RACK_ENV'] ||= 'development'

require 'omniauth-github'

Dir[File.dirname(__FILE__) + "/initializers/*"].each do |initializer|
  require initializer
end