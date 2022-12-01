class Api::V1::DebtsController < ApplicationController
  def index
    @debts = Debt.all
    render json: @debts, except: [:user_id, :created_at, :updated_at],
    include: [user:{except:[:created_at, :updated_at]}]
  end


  def show
    @debt = Debt.find_by(id: params[:id])
    if debt
      render json: @debt, status: 200
    else
      render json: {
        error: "Debt not found"
      }
    end
  end


  def create
    @debt = Debt.new(
      description: debt_params[:description],
      category: debt_params[:category],
      price: debt_params[:price],
      date: debt_params[:date],
      paid: debt_params[:paid],
      user_id: deb_params[:user_id]
    )
    if @debt.save
      render json: @debt, status: 200
    else
      render json: {
        error: "Error Creating..."
      }
    end
  end


  def update
    debt = Debt.find_by(id: params[:id])
    if debt
      debt.update(description: params[:description], category: params[:category], price: params[:price], date: params[:date], paid: params[:paid])
      render json: debt, status: 200
    else
      render json: {
        error: "Debt not found"
      }
    end
  end


  def destroy
    debt = Debt.find_by(id: params[:id])
    if debt
      debt.destroy
      render json: "Debt has been deleted successfully"
    else
      render json: {
        error: "Debt has not been deleted"
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
