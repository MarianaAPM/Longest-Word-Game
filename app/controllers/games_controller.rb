require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)    
  end
  
  def score
    @user_word = params[:word].upcase
    @letters = params[:letters].upcase.split

    chars = @user_word.chars.all? {|letter| @user_word.count(letter) <= @letters.count(letter)}

    filepath = open("https://wagon-dictionary.herokuapp.com/#{@user_word}")
    @english_word = JSON.parse(filepath.read)

    @results = ""

    if chars == false
      @results = "Sorry, but #{@user_word} can't be built out of the given letters!"
    elsif chars && @english_word["found"] == false
      @results = "Sorry, but #{@user_word} does not seem to be a valid English word.."
    else
      @results = "Congratulations! #{@user_word} is a valid English word!"
    end
  end
end








