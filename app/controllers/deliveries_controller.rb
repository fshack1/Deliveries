# frozen_string_literal: true

class DeliveriesController < ApplicationController
  before_action :set_delivery, only: %i[show edit update destroy]

  # GET /deliveries
  def index
    @total_records = Delivery.all
    deliveries = @total_records

    if params[:driver_name].present?
      deliveries = deliveries.where(driver_name: params[:driver_name])
    end

    if params[:pickup_address].present?
      deliveries = deliveries.where(pickup_address: params[:pickup_address])
    end

    @pagy, @records = pagy(deliveries.order(created_at: :desc), limit: 7)
    @total_cost = Delivery.sum(:cost)
  end

  # GET /deliveries/1
  def show
  end

  # GET /deliveries/new
  def new
    @delivery = Delivery.new
  end

  # GET /deliveries/1/edit
  def edit
  end

  # POST /deliveries
  def create
    @delivery = Delivery.new(delivery_params)

    respond_to do |format|
      if @delivery.save
        format.html { redirect_to @delivery, notice: "Delivery was scheduled successfully." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /deliveries/1
  def update
    respond_to do |format|
      if @delivery.update(delivery_params)
        format.html { redirect_to @delivery, notice: "Delivery was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /deliveries/1
  def destroy
    @delivery.destroy!

    respond_to do |format|
      format.html { redirect_to deliveries_path, status: :see_other, notice: "Delivery was successfully destroyed." }
    end
  end

  # GET /deliveries/total_cost
  def total_cost
    @deliveries = Delivery.all.order(id: :desc)
    @total_cost = @deliveries.sum(:cost)

    @pagy, @records = pagy_countless(@deliveries, limit: 5)

    respond_to do |format|
      format.html
      format.turbo_stream do
        render(turbo_stream: turbo_stream.replace(
          "sideview-content",
          partial: "deliveries/total_cost_table",
          locals: { deliveries: @deliveries, total_cost: @total_cost, pagy: @pagy }
        ))
      end
    end
  end

  # GET /deliveries/optimized_routes
  def optimized_routes
    grouped_deliveries = Delivery.all.group_by(&:pickup_address)

    @optimized_routes = grouped_deliveries.transform_values do |group|
      group.sort_by(&:distance)
    end

    respond_to do |format|
      format.html { render :optimized_routes, locals: { optimized_routes: @optimized_routes } }
    end
  end

  private def set_delivery
    @delivery = Delivery.find(params[:id])
  end

  private def delivery_params
    params.require(:delivery).permit(:pickup_address, :delivery_address, :weight, :distance, :scheduled_time, :cost, :driver_name)
  end
end
