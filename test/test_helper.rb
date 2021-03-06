ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class CarrierWave::Mount::Mounter
  def store!
    # Not storing uploads in the tests
  end
end

class ActiveSupport::TestCase
  include ActionDispatch::TestProcess

  fixtures :all

  CarrierWave.root = Rails.root.join('test/fixtures/files')

  def json(response, symbolize = true)
    JSON.parse(response, symbolize_names: symbolize, quirks_mode: true)
  end

  def token_header(token)
    ActionController::HttpAuthentication::Token.encode_credentials(token)
  end

  def after_teardown
    super
    CarrierWave.clean_cached_files!(0)
  end
end

class ActionController::TestCase
  include Devise::TestHelpers
end
