require 'net/http'
require 'sinatra'
require 'rest_client'

set :bind, '0.0.0.0'

get '/builds/:build' do

  if params[:status] == 'success'
    RestClient.get 'http://localhost:4321/api/robots/arduino_bcn/commands/jobs_works'
  elsif params[:status] == 'failure'
    RestClient.get 'http://localhost:4321/api/robots/arduino_bcn/commands/jobs_broken'
  end

end
