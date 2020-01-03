# frozen_string_literal: true

require 'json'

class ExpenseController < ApplicationController
  def index; end

  def create
    paid_by = User.find_by_name(params[:paid_by])
    paid_for = JSON.parser(params[:paid_for])
    render json: { message: 'User does not exist' }, status: 422 if non_existing_user_found(paid_for.keys)
    Expense.create(paid_by: paid_by.id, paid_for: params[:paid_for], amount: params[:amount], created_by: params[:created_by])
    paid_for.each do |k, v|
      owed_by = User.find_by_name(k)
      next if owed_by.id == paid_by.id

      settlement = Settlement.where(owed_by: owed_by.id, owed_to: paid_by.id)
      Settlement.create(owed_by: owed_by.id, owed_to: paid_by.id, amount: v) unless settlement.present?
      settlement_amount = settlement.amount - v.to_i
      if settlement_amount == 0
        settlement.destroy!
      elsif settlement_amount < 0
        settlement.update(owed_by: paid_by.id, owed_to: settlement.owed_by, amount: settlement_amount.abs)
      else
        settlement.update(amount: settlement_amount)
      end
    end
  end

  def show; end

  def update; end

  def destroy; end

  private

  def params
    params.permit(:paid_by, :amount, :paid_for, :distribution_type, :created_by)
  end

  def non_existing_user_found(paid_for)
    paid_for.each do |user|
      return false unless User.find_by_name(user).present?
    end
    true
  end
end
