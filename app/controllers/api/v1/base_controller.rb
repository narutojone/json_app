class Api::V1::BaseController < ApplicationController
  layout false
  skip_before_action :verify_authenticity_token
end
