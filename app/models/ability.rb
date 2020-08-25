# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    alias_action :create, :read, :update, :destroy, to: :crud

    can(:crud, Recipe) do |recipe|
      recipe.user == user # current_user
    end

    can(:crud, Comment) do |comment|
      comment.user == user # current_user
    end
  end
end