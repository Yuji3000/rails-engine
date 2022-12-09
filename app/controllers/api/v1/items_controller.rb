class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.all)
  end

  def show
    begin
      render json: ItemSerializer.new(Item.find(params[:id]))
    rescue ActiveRecord::RecordNotFound => exception
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
    item = Item.find(params[:id])
    n_item = item.invoices.each do |invoice|

      if invoice.items.count > 1
        item.destroy
      else
        invoice.destroy
        item.destroy
      end
    end
    render json: ItemSerializer.new(n_item)
  end

private
  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end
