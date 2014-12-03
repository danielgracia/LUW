class InvitesController < ApplicationController
  before_action :require_user

  def invite
    p params
    InviteMailer.send_invite(current_user, params[:email]).deliver
    head :ok
  end

end
