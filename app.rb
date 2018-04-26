require "sinatra"
require "erb"
require_relative "tictactoe_methods.rb"

enable :sessions


#
# p = Game.new
# p.play

get "/" do
	erb :board
end


post "/" do
	redirect "/"
end
