# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Logged in user abilities
    return unless user.present?

    can :index, Race, {participants: {user_id: user.id}}
    can :index, Race, {owners: {id: user.id}}
  end
end
