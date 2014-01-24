require 'pry'
require 'sinatra'
require 'sinatra/reloader'

get '/' do
  erb "Welcome to the CALCULATION STATION! Use as:
  /math/\#/[operation]/\# \n Operations are: sum sub mult div"
end

get '/math/*/*/*' do # Injects so scalable in the future
  case params[:splat].delete_at(1)

  when 'sum'
    @operation = 'add'
    code = params[:splat].inject(0) do |sum, val|
      sum += val.to_i
    end
    @string = "#{params[:splat][0]} plus #{params[:splat][1]} is #{code}"

  when 'sub'
    @operation = 'subtraction'
    code = params[:splat][0].to_i - params[:splat][1].to_i
    @string = "#{params[:splat][0]} minus #{params[:splat][1]} is #{code}"

  when 'mult'
    @operation = 'multiplication'
    code = params[:splat].inject(1) do |prod, val|
      prod *= val.to_i
    end
    @string = "#{params[:splat][0]} times #{params[:splat][1]} is #{code}"

  when 'div'
    @operation = 'division'
    code = params[:splat].inject do |result, val|
      result = result.to_f / val.to_f
    end
    @string = "#{params[:splat][0]} divided by #{params[:splat][1]} is #{code}"
  end
  erb :calc
end

get '/dice/:sides' do
  @result = 1 + rand(params[:sides].to_i)
  @sides = params[:sides]
  erb :dice
end
