class ApplicationController < ActionController::Base
  include Devise::Controllers::Helpers

  def after_sign_up_path_for(resource)
    return unless resource.is_a?(User)

    recipes_path
  end
end
