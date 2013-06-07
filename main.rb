require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

ActiveRecord::Base.establish_connection(
  :adapter => 'postgresql',
  :host => 'localhost',
  :username => 'alexlin',
  :password => '',
  :database => 'wall_street',
  :encoding => 'utf8'
)

require_relative "client"
require_relative "stock"
require_relative "portfolio"

get "/" do
  @clients = Client.all
  @portfolios = Portfolio.all
  @stocks = Stock.all

  erb :index
end

# CLIENTS
get "/new_client" do
  erb :new_client
end

post "/new_client" do
  @client = Client.new(params[:client])
    if @client.save
      redirect "/"
    else
      erb :new_client
    end
end

# STOCKS
get "/new_stock" do
  erb :new_stock
end

post "/new_stock" do
  @stock = Stock.new(params[:stock])
  if @stock.save
    redirect "/"
  else
    erb :new_stock
  end
end

# PORTFOLIOS
get "/new_portfolio" do
  erb :new_portfolio
end

post "/new_portfolio" do
  @portfolio = Portfolio.new(params[:portfolio])

  if @portfolio.save
    redirect "/"
  else
    erb :new_portfolio
  end
end

get "/edit_portfolio/:portfolio_id" do
  @portfolio = Portfolio.find_by_id(params[:portfolio_id])
  erb :edit_portfolio
end

post "/save_portfolio/:portfolio_id" do
  @portfolio = Portfolio.find_by_id(params[:portfolio_id])
  if @portfolio.update_attributes(params[:portfolio])
    redirect "/"
  else
    erb :edit_portfolio
  end
end

get "/edit_client/:client_id" do
  @client = Client.find_by_id(params[:client_id])
  erb :edit_client
end

post "/save_client/:client_id" do
  @client = Client.find_by_id(params[:client_id])

  if @client.save

    @portfolio = Portfolio.create(params[:portfolio])
    @client.update_attributes(params[:client])
    @portfolio.update_attributes(:client_id => @client.id)
    redirect "/"
  else
    erb :edit_client
  end
end






post "/delete_client/:client_id" do
  @client = Client.find_by_id(params[:client_id])
  @client.delete
  redirect "/"
end




