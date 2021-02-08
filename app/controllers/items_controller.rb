class ItemsController < ApplicationController
  before_action :make_item, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only:[:index, :show]

    def index
      @items = Item.all
    end

    def show
    end

    def new
      @item = Item.new
      @category = Category.new
    end

    def create
      @item = Item.new(item_params)
      @category = Category.new
      @item.user = current_user
      if @item.save
        redirect_to new_item_item_category_path(@item)
        flash[:alert] = 'You have successfully added your item.'
      else
        render :new
      end
    end

    def edit
    end

    def update
      if @item.update(item_params)
        redirect_to item_path(@item)
      else
        render :edit
      end
    end

    def destroy
      @item.destroy
      redirect_to root_path
    end

    private

    def make_item
      @item = Item.find(params[:id])
    end

    def item_params
      params.require(:item).permit(:name, :price, :size, :description)
    end
end
