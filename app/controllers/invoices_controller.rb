class InvoicesController < ApplicationController
  before_action :authenticate_user!
  before_action :confirm_admin, only: [:new, :create, :edit, :udpate, :destroy]
  before_action :set_invoice, only: [:show, :edit, :update, :destroy, :send_form, :send_invoice]
  

  respond_to :html

  def index
    if current_user.admin?
      @invoices = Invoice.all
    else
      @invoices = Invoice.where user_id: current_user.id
    end
  end

  def show
    if current_user.admin? === false && current_user.id != @invoice.user_id
      render :unauthorized
    end
    @invoices = @user_id.invoices
  end

  def new
    @invoice = Invoice.new
    respond_with(@invoice)
  end

  def edit
  end

  def unauthorized
  end

  def create
    @invoice = Invoice.new(invoice_params)
    @invoice.user_id = current_user.id
    respond_to do |format|
      if @invoice.save
        format.html { redirect_to @invoice, notice: 'Invoice was successfully created.' }
        format.json { render :show, status: :created, location: @invoice }
      else
        format.html { render :new }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @invoice.update(invoice_params)
        format.html { redirect_to @invoice, notice: 'Invoice was successfully updated.' }
        format.json { render :show, status: :ok, location: @invoice }
      else
        format.html { render :edit }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @invoice.destroy
    respond_to do |format|
      format.html { redirect_to invoices_url, notice: 'Invoice was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  def send_invoice
    to_email = params['to_email']
    message = params['message']
    ListMailer.email_invoice(@invoice, current_user.email, to_email, message).deliver
    redirect_to @invoice, notice: "The invoice has been sent!"
  end

  private
    def set_invoice
      @invoice = Invoice.find(params[:id])
    end

    def invoice_params
      params[:invoice].permit(:title, :due_date, :charge_amount, :work_items, :user_id)
    end

    # def confirm_owner
    #   redirect_to invoices_url, notice: "You are not allowed to access that invoice." if current_user.id != @invoice.user_id
    # end

    def confirm_admin
      render :unauthorized if current_user.admin? === false
    end
end
