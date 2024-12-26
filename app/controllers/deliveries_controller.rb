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

    @pagy, @records = pagy(deliveries.order(created_at: :desc), limit: 3)
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

  def total_cost
    deliveries = Delivery.all.order(id: :desc)
    @total_cost = deliveries.sum(:cost)

    respond_to do |format|
      format.html { render partial: "cost_breakdown", locals: { deliveries:, total_cost: @total_cost } }
    end
  end

  private def set_delivery
      @delivery = Delivery.find(params.expect(:id))
    end

    private def delivery_params
      params.expect(delivery: [ :pickup_address, :delivery_address, :weight, :distance, :scheduled_time, :cost, :driver_name ])
    end
end
