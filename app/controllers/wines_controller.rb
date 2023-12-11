class WinesController < ApplicationController

  def index
    result = RestClient.get Rails.application.config_for(:local_env)['api-url']
    @wines = JSON.parse(result.body, symbolize_names: true)[:matches]
  end
end
