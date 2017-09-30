class TicketsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_ticket, only: [:edit, :update]
  load_and_authorize_resource

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

  def edit
  end

  def update
    if @ticket.update(ticket_params)
      redirect_to tickets_manage_path, :notice => "Ticket handled"
    else
      render "edit"
    end
  end

  def manage
    if current_user.has_role? :admin
      @tickets = Ticket.all.order("created_at DESC")
      render "manage"
    else
      redirect_to root_path
    end
  end

  private
    def ticket_params
      params.require(:ticket).permit(:description, :is_processed)
    end

    def find_ticket
      @ticket = Ticket.find(params[:id])
    end

end
