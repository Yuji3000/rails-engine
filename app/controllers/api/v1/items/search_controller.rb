class Api::V1::Items::SearchController < ApplicationController
  def index
    item = Item.find_by_name(params[:name])
    render json: ItemSerializer.new(item)
    # require 'pry'; binding.pry
  end
end