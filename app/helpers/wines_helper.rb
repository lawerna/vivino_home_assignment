module WinesHelper
  def country_code(wine)
    wine[:vintage][:wine][:region][:country]
  end

  def country_image_url(wine)
    "#{Rails.application.config_for(:local_env)['assets-url']}/countryFlags/#{country_code(wine).upcase}-48.png"
  end

  def ratings_average(wine)
    wine[:vintage][:wine][:statistics][:ratings_average]
  end

  def star_red_counter(wine)
    ratings_average(wine).floor
  end

  def star_blank_counter(wine)
    (5 - star_red_counter(wine))
  end

  def countries_for_filtering
    [['Argentina', 'ar'], ['Australia', 'au'], ['Austria', 'at'], ['Chile', 'cl'], ['France', 'fr'], ['Germany', 'de'], ['Italy', 'it'], ['Portugal', 'pt'], ['South Africa', 'za'], ['Spain', 'es'], ['United States', 'us']]
  end
end
