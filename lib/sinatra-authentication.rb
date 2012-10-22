require 'sinatra/base'

module Sinatra
  module SinatraAuth
    def self.registered(app)
      app.get '/users/:id' do
        login_required

        user = User.get(:id => params[:id])
        user.to_json
      end

      app.post '/login' do
        if user = User.authenticate(params[:email], params[:password])
          user.to_json
        else
          {:error => 'incorrect password or email'}.to_json
        end
      end

      app.post '/signup' do
        user = User.new(params[:user])
        if user.save
          user.to_json
        else
          {:error => user.errors}.to_json
        end
      end

    end
  end

  register SinatraAuth
end
