class Api::V1::Merchants::SearchController < ApplicationController
  def show
    if
      merchant = Merchant.find_merchant_by_name(params[:name])
      render json: MerchantSerializer.new(merchant)
    else
      render json: { data: { error: 'Merchant does not exist'}}, status: 404
    end
  end
end



