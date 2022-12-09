class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.all)
  end

  def show
    begin
      render json: ItemSerializer.new(Item.find(params[:id]))
    rescue ActiveRecord::RecordNotFound => exception
      # render json: ErrorItem.new("Item does not exist", 'Not Found', 404)
      # render json: ErrorItemSerializer.new(ErrorItem.new("Item does not exist", 'Not Found', 404))
      render json: { errors: { details: 'Item does not exist '}}, status: 404
    end
  end

  def create
    new_item = Item.create!(item_params)

    if new_item.save
      render json: ItemSerializer.new(new_item), status: 201
    end
  end
  
  def update
    item = Item.find(params[:id])
    if Merchant.exists?(item_params[:merchant_id]) || item_params[:merchant_id] == nil
      item.update(item_params)
      render json:ItemSerializer.new(item)
    else
      render json: { errors: { details: 'Merchant does not exist '}}, status: 400
    end
  end

  def destroy
    # Transaction.where("invoice_id = ?", "#{params[:id]}").destroy
    item = Item.find(params[:id])
# require 'pry'; binding.pry
    # if params[:id] != nil
    #   item.invoices.each do |invoice|
    #     # require 'pry'; binding.pry
    #     invoice.transactions.destroy
    #   end
      # require 'pry'; binding.pry
    item.invoices.destroy
    item.destroy
    render json: ItemSerializer.new(item)
  
  end

private
  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end
