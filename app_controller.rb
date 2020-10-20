require 'sinatra'
require_relative 'init.rb'


get "/" do
  erb :form
end


post '/process_file' do
  @final_forest_root_arr = ProcessFile.new(
   ).analyze_and_process_inputs( 
     params[:file][:tempfile]
     )
  erb :show_text
end
set :public_folder, 'public'
get "/coverage" do
  redirect 'coverage/index.html' 
end
get '/doc' do
  redirect '/doc/index.html' 
end