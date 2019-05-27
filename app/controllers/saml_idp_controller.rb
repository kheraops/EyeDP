# frozen_string_literal: true

class SamlIdpController < SamlIdp::IdpController
  # rubocop:disable Rails/LexicallyScopedActionFilter
  before_action :authenticate_user!, except: [:show]
  # rubocop:enable Rails/LexicallyScopedActionFilter

  # override create and make sure to set both "GET" and "POST" requests to /saml/auth to #create
  def create
    # binding.pry
    if user_signed_in?
      @saml_response = idp_make_saml_response(current_user)
      render template: 'saml_idp/idp/saml_post', layout: false
      nil
    else
      # it shouldn't be possible to get here, but lets render 403 just in case
      render status: :forbidden
    end
  end

  # NOT USED -- def idp_authenticate(email, password) -- NOT USED

  private

  # not using params intentionally
  def idp_make_saml_response(found_user)
    encode_response found_user
  end
end
