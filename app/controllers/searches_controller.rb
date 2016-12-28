# search index and results page
# /searches
class SearchesController < ApplicationController
  before_action :set_search, only: [:index]

  # GET root
  #
  # renders the search form
  def index
  end

  # POST '/searches'
  #
  # performs the actual search by contact the Favorito::Client
  def create
    @search = Search.perform(search_params)
    @decorated_result = decorated_result(@search)
  end

  private

  def set_search
    @search = Search.new
  end

  def decorated_result(search)
    Favorito::Presenter.new(search.result)
  end

  def search_params
    params.require(:search).permit(:username)
  end
end
