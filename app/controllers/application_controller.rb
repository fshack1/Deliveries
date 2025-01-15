# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend
  include CanCan::ControllerAdditions
  allow_browser versions: :modern
end
