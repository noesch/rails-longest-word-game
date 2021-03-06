class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << ('A'..'Z').to_a.sample }
    @letters
  end

  def check(word)
    require 'open-uri'
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    JSON.parse(open(url).read)['found']
  end

  def score
    word = params[:word]
    grid = params[:letters]
    solution = word.upcase.split('')
    letters = grid.split('')
    if (solution & letters) != solution
      @prompt = "Sorry, #{word} can not be built with #{grid}!"
    elsif check(word)
      @prompt = "Congratulations, you won. Your score is #{word.length * 10} points!"
    else
      @prompt = "Sorry, #{word} is not in the dictionary"
    end
  end
end
