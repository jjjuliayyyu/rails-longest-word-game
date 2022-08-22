require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = (0...9).to_a.map! { ('A'..'Z').to_a.sample }
  end

  def score
    @message = ''

    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    search = URI.open(url).read
    hash = JSON.parse(search)

    characters_are_in_grid = true
    params[:word].upcase.each_char do |character|
      characters_are_in_grid =params[:letters].include?(character)
      break if characters_are_in_grid == false
    end

    if hash['found'] && characters_are_in_grid
      @message = "#{params[:word]} is valid according to the grid and is an English word"
    elsif !hash['found'] && characters_are_in_grid
      @message = "#{params[:word]} is valid according to the grid, but is not a valid English word"
    else
      @message = "#{params[:word]} can’t be built out of the original grid"
    end
  end
end
