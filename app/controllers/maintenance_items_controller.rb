class MaintenanceItemsController < ApplicationController
  before_action :set_maintenance_item, only: [:show, :edit, :update, :destroy]

  def index
    if current_user
      @maintenance_items = current_user.maintenance_items

      #For use with the 'show categories' button from the Maintenance Items Show page, copied below
      # <%= link_to  "Show Categories", maintenance_item_path(item), id: "categoryBtn_#{item.id}" ,class: 'btn align-self-center badge badge-primary' %>
      
      # @maintenance_item_ids = current_user.maintenance_item_ids
      # @cat_names = []
      # @logs = []
      # @maintenance_item_ids.each do |id|
      #   @logs << MaintenanceLog.find_by(maintenance_item_id: id)
      #   @logs.each do |log|
      #     @cat_names << MaintenanceCategory.find(log.maintenance_category_id).name
      #   end
      # end
 
    else 
      redirect_to new_user_session_path
    end

    respond_to do |format|
      format.html { render :index}
      format.json { render json: @maintenance_items}
    end
  end

  def new
    @maintenance_item = MaintenanceItem.new
  end

  def create
    @maintenance_item = current_user.maintenance_items.build(maintenance_item_params)
    if @maintenance_item.save
      redirect_to maintenance_item_path(@maintenance_item)
    else
      render :new
      # @maintenance_items = MaintenanceItem.all
      # redirect_to new_maintenance_item_path, alert: "Please enter a valid maintenance item"
    end
  end

  def update
    @maintenance_item.update(maintenance_item_params)
    redirect_to maintenance_item_path(@maintenance_item)
  end

  def destroy
    @maintenance_item.destroy
    redirect_to maintenance_items_path
  end

  def show
     # For use with form to make new log
    @maintenance_log = @maintenance_item.maintenance_logs.build
    render 
  end

  def edit 
  end

  private

  def set_maintenance_item
    @maintenance_item = MaintenanceItem.find(params[:id])
  end

  def maintenance_item_params
    params.require(:maintenance_item).permit(:name, :user_id)
  end

end
