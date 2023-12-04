# frozen_string_literal: true

class Race::ItemComponent < ViewComponent::Base
  with_collection_parameter :race
  def initialize(race:, user:)
    @race = race
    @user = user
  end
end
