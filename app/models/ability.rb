# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new

    if user.is_admin? 
      can :manage, :all 
    end

    alias_action :create, :read, :update, :destroy, to: :crud

    can(:crud, Recipe) do |recipe|
      recipe.user == user # current_user
    end

    can(:crud, Comment) do |comment|
      comment.user == user # current_user
    end


    can :like, Recipe do |recipe|
      user.present? && recipe.user != user
    end

    can :destroy, Like  do |like|
      like.user == user
    end

  end
end