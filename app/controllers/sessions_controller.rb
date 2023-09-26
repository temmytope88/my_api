class SessionsController < ApplicationController
    def create
       #puts request.env['omniauth.auth']
       user_info = request.env['omniauth.auth']
       #puts user_info.credentials.refresh_token
       #binding.pry
        if user_info
            @user = User.find_by(google_id: user_info.uid)

            if @user.nil?
                @user = User.create(
                    google_id: user_info.uid,
                    name: user_info.info.name,
                    token: user_info.credentials.token,
                    expires_at: Time.at(user_info.credentials.expires_at).to_datetime 
                ) 
            else
                @user.update(
                    token: user_info.credentials.token,
                    expires_at: Time.at(user_info.credentials.expires_at).to_datetime
                )
            end 

            session[:user_id] = @user.id 
            render '/orders/staticpage', notice: "successfully authorised"
        else
            render '/orders/staticpage', alert: "not authorised"
        end
    end    
end
