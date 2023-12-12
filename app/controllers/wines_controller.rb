class WinesController < ApplicationController

  def index
    url = Rails.application.config_for(:local_env)['api-url']
    if params[:query].present?
      params[:query].each do |country|
        url += "&country_codes%5B%5D=#{country}"
      end
    end
    
    result = RestClient.get url
    @wines = JSON.parse(result.body, symbolize_names: true)[:matches]
  end
end
