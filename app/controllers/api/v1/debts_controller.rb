class Api::V1::DebtsController < ApplicationController
  def index
    @index_debts = Debt.all
    render json: @index_debts, except: [:user_id, :created_at, :updated_at],
    include: [user:{except:[:created_at, :updated_at]}]
  end


  def show
    @show_debt_by_id = Debt.find_by(id: params[:id])
    if @show_debt_by_id
      render json: @show_debt_by_id, status: 200
    else
      render json: {
        error: "Debt not found", status: 404
      }
    end
  end


  def create
    @debt_creation = Debt.new(
      description: debt_params[:description],
      category: debt_params[:category],
      price: debt_params[:price],
      date: debt_params[:date],
      paid: debt_params[:paid],
      user_id: debt_params[:user_id]
    )
    if @debt_creation.save
      render json: @debt_creation, status: 200
    else
      render json: {
        error: "Error Creating...", status: 400
      }
    end
  end


  def update
    @debt_update = Debt.find_by(id: params[:id])
    if @debt_update
      @debt_update.update(description: params[:description], category: params[:category], price: params[:price], date: params[:date], paid: params[:paid])
      render json: @debt_update, status: 200
    else
      render json: {
        error: "Debt not found", status: 404
      }
    end
  end


  def destroy
    @debt_destroy = Debt.find_by(id: params[:id])
    if @debt_destroy
      @debt_destroy.destroy
      render json: "Debt has been deleted successfully", status: 200
    else
      render json: {
        error: "Debt has not been deleted", status: 400
      }
    end
  end


  private
  def debt_params
    params.require(:debt).permit([
      :description,
      :category,
      :price,
      :date,
      :paid,
      :user_id
    ])
  end

end
