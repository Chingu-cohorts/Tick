class TicketsController < ApplicationController
  before_action :authenticate_user!

  def index
    @tickets = current_user.tickets.order("created_at DESC")
  end

  def new
    @ticket = Ticket.new
  end

  def create
    @ticket = Ticket.create(ticket_params)
    @ticket.user = current_user

    if @ticket.save
      redirect_to tickets_path, :notice => "Ticket submitted!"
    else
      render "new"
    end
  end

  private
    def ticket_params
      params.require(:ticket).permit(:description)
    end
end
