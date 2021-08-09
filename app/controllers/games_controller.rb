class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << ('A'..'Z').to_a.sample }
    @letters
  end

  def score
    require 'net/http'
    require 'json'

    base_url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    uri = URI(base_url)
    response = Net::HTTP.get(uri)
    check = JSON.parse(response)['found']

    solution = params[:word].upcase.split('')
    @letters = params[:letters].split('')
    if (solution & @letters) != solution
      @prompt = "Sorry, #{params[:word]} can not be built with #{@letters}!"
    elsif check
      @prompt = "Congratulations, you won. Your score is #{params[:word].length * 10} points!"
    else
      @prompt = "Sorry, #{params[:word]} is not in the dictionary"
    end
  end

end
