class Customers::RegistrationsController < Devise::RegistrationsController
  protected

  # Allow update WITHOUT password
  def update_resource(resource, params)
    params.delete(:current_password)   
    resource.update_without_password(params)
  end
end