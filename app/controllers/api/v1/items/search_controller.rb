class Api::V1::Items::SearchController < ApplicationController
  def index
    item = Item.find_by_name(params[:name])
    render json: ItemSerializer.new(item)
  end

  # def find_all

  # end
end

