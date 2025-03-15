class WalletsController < ApplicationController
  before_action :set_wallet, except: :transfer

  def deposit
    @transaction = CreditTransaction.create!(wallet: @wallet, amount: params[:amount])
    render json: @transaction, status: :created
  end

  def withdraw
    @transaction = DebitTransaction.create!(wallet: @wallet, amount: params[:amount])
    render json: @transaction, status: :created
  end

  def transfer
    @source_wallet = Wallet.find(params[:source_wallet_id])
    @target_wallet = Wallet.find(params[:target_wallet_id])
    @transaction = TransferTransaction.create!(wallet: @source_wallet, amount: params[:amount], source_wallet: @source_wallet, target_wallet: @target_wallet)
    render json: @transaction, status: :created
  end

  def balance
    render json: { balance: @wallet.balance }
  end

  private

  def set_wallet
    @wallet = Wallet.find(params[:id])
  end
end
