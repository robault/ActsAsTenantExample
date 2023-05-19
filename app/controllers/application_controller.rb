class ApplicationController < ActionController::Base
  set_current_tenant_through_filter
  before_action :set_tenant

  def set_tenant
    set_current_tenant(current_user) # this determines the tenant, for now the lookup is done based on the Devise current_user
  end

  # I'm adding this method to redirect the user to the posts page after login
  def after_sign_in_path_for(resource)
    stored_location_for(resource) || posts_path
  end
end
