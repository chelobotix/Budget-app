# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can :manage, :all, author_id: user.id if user.role == 'user'
  end
end
