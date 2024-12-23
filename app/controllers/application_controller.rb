# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend
  allow_browser versions: :modern
end
