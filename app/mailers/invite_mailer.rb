class InviteMailer < ActionMailer::Base
  default from: "sharedunifesp@gmail.com"

  def send_invite(user, email)
    invite = user.invites.create!
    invite.reload

    @user = user
    @email = email
    @token = invite.token

    mail to: email, subject: "Convite para o UNIFESP Shared"
  end
end
