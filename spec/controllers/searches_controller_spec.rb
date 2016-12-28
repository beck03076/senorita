require 'rails_helper'

RSpec.describe SearchesController, type: :controller do
  describe 'GET index' do
    it 'assigns @search' do
      get :index
      expect(assigns(:search)).to be_kind_of(Search)
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end
  end

  describe 'POST create' do
    it 'renders the create template' do
      VCR.use_cassette('favorito_client_page_nonil_cassettes') do
        post :create, params: { search: { username: 'beck03076' } }

        expect(response).to render_template('create')
      end
    end

    it 'assign @decorated_result' do
      VCR.use_cassette('favorito_client_page_nonil_cassettes') do
        post :create, params: { search: { username: 'beck03076' } }

        expect(assigns(:decorated_result)).to be_kind_of(Favorito::Presenter)
      end
    end

    it 'assign @decorated_result with favorite language and languages group' do
      VCR.use_cassette('favorito_client_page_nonil_cassettes') do
        post :create, params: { search: { username: 'beck03076' } }

        expect(assigns(:decorated_result).favorite_language).to eq('Ruby')
        expect(assigns(:decorated_result).sorted_languages_group)
          .to be_kind_of(Array)
        expect(assigns(:decorated_result).sorted_languages_group.first[0])
          .to eq('Ruby')
      end
    end
  end
end
