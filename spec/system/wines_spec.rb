# frozen_string_literal: true

require 'rails_helper'

describe 'Wine page', type: :system do
  before do
    stub_request(:get, 'https://api.vivino.com/vintages/_explore?limit=50&q=cabernet%20sauvignon').
      to_return(status: 200, body: {
        'market' => { 'country' => 'dk', 'currency' => 'DKK'},
        'records_matched' => 2921,
        'matches' => [
          { 'vintage' => {
            'id' => 1,
            'year' => '2018',
            'name' => 'Vintage 1',
            'statistics' => {},
            'image' => {
              'variations' => {
                'bottle_large' => '//images.vivino.com/thumbs/LF-nwd1IQDOg-NOy10PqDw_pb_x960.png',
                'bottle_medium' => '//images.vivino.com/thumbs/LF-nwd1IQDOg-NOy10PqDw_pb_x600.png'
              }
            },
            'wine' => {
              'id' => 2,
              'name' => 'Wine 1',
              'region' => {
                'id' => 1,
                'name' => 'Region 1',
                'country' => 'dk',
                'background_image' => {}
              },
              'winery' => {
                'id' => 4,
                'name' => 'Winery 111',
                'seo_name' => 'seo name',
                'status' => 0,
                'background_image' => nil},
              'taste' => {},
              'statistics' => {
                'status' => 'Normal',
                'ratings_count' => 76,
                'ratings_average' => 2.7,
                'labels_count' => 26009,
                'vintages_count' => 39
              }
            }
          }},
          { 'vintage' => {
            'id' => 2,
            'year' => '2021',
            'name' => 'Vintage 2',
            'statistics' => {},
            'image' => {
              'variations' => {
                'bottle_large' => '//images.vivino.com/thumbs/LF-nwd1IQDOg-NOy10PqDw_pb_x960.png',
                'bottle_medium' => '//images.vivino.com/thumbs/LF-nwd1IQDOg-NOy10PqDw_pb_x600.png'
              }
            },
            'wine' => {
              'id' => 5,
              'name' => 'Wine 5',
              'region' => {
                'id' => 6,
                'name' => 'Region 11',
                'country' => 'pl',
                'background_image' => {}
              },
              'winery' => {
                'id' => 4,
                'name' => 'Winery 90',
                'seo_name' => 'seo name',
                'status' => 0,
                'background_image' => nil},
              'taste' => {},
              'statistics' => {
                'status' => 'Normal',
                'ratings_count' => 1255,
                'ratings_average' => 4.7,
                'labels_count' => 26009,
                'vintages_count' => 39
              }
            }
          }},
        ]
      }.to_json)

    stub_request(:get, 'https://api.vivino.com/vintages/_explore?limit=50&q=cabernet%20sauvignon&country_codes%5B%5D=ar').
      to_return(status: 200, body: {
        'market' => { 'country' => 'dk', 'currency' => 'DKK'},
        'records_matched' => 2921,
        'matches' => [
          { 'vintage' => {
            'id' => 2,
            'year' => '2021',
            'name' => 'Vintage 2',
            'statistics' => {},
            'image' => {
              'variations' => {
                'bottle_large' => '//images.vivino.com/thumbs/LF-nwd1IQDOg-NOy10PqDw_pb_x960.png',
                'bottle_medium' => '//images.vivino.com/thumbs/LF-nwd1IQDOg-NOy10PqDw_pb_x600.png'
              }
            },
            'wine' => {
              'id' => 5,
              'name' => 'Wine 5',
              'region' => {
                'id' => 6,
                'name' => 'Region 11',
                'country' => 'ar',
                'background_image' => {}
              },
              'winery' => {
                'id' => 4,
                'name' => 'Winery 90',
                'seo_name' => 'seo name',
                'status' => 0,
                'background_image' => nil},
              'taste' => {},
              'statistics' => {
                'status' => 'Normal',
                'ratings_count' => 1255,
                'ratings_average' => 4.7,
                'labels_count' => 26009,
                'vintages_count' => 39
              }
            }
          }},
        ]
      }.to_json)
  end

  describe 'index' do
    it 'shows page header' do
      visit root_path

      assert_selector 'h1', text: 'Here is a list of wines we are currently offer'
    end

    it 'shows information about wines' do
      visit root_path

      assert_text 'Winery 111'
      assert_text 'Wine 1'
      assert_text '2018'
      assert_text 'Denmark'
      assert_text 'Region 1'
      assert_text '2.7'
      assert_text '76'

      assert_text 'Winery 90'
      assert_text 'Wine 5'
      assert_text '2021'
      assert_text 'Poland'
      assert_text 'Region 11'
      assert_text '4.7'
      assert_text '1255'
    end

    it 'display correct numbers of starts' do
      visit root_path

      assert_selector '.star-red', count: 6
      assert_selector '.star-blank', count: 4
    end

    it 'displays correctly select' do
      visit root_path

      expect(page.all('label').map(&:text)).to eq(['Argentina', 'Australia', 'Austria', 'Chile', 'France', 'Germany', 'Italy', 'Portugal', 'South Africa', 'Spain', 'United States'])
    end

    it 'filters correctly wines' do
      visit root_path

      assert_selector '.card-body', count: 2
      assert_text 'Argentina'
      assert_text 'Denmark'

      find(:css, 'label[for="query_ar"]').set(true)

      assert_selector 'h1', text: 'Here is a list of wines we are currently offer'

      assert_selector '.card-body', count: 1
      assert_text 'Argentina'
      assert_no_text 'Denmark'
    end
  end
end
