class TicketsController < ApplicationController
  def index
    @tickets = Ticket.order(created_at: :desc).paginate(page: params[:page] || 1, per_page: params[:per_page] || 20)
  end

  def show
    @ticket = Ticket.find(params[:id])
  end
end
