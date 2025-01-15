# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.admin?
      can :summary, Delivery
    else
      cannot :summary, Delivery
    end
  end
end
