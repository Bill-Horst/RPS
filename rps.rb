class Printer
  def out (message)
    puts message
  end
end

class Presentation

  def initialize()
    @p = Printer.new
  end

  def show_welcome_message
    @p.out('Welcome. Let\'s start')
  end

  def show_rps_choices
    @p.out('1: Rock')
    @p.out('2: Scissors')
    @p.out('3: Paper')
  end

  def show_goodbye_message
    @p.out('Goodbye')
  end

  def show_menu
    @p.out('1: Play "Rock, Paper, Scissors"')
    @p.out('2: Quit the game')
  end

  def show_error_message
    @p.out('I don\'t know what you\'re talking about. Try again.')
  end

  def you_win_message
    @p.out('You win!')
  end

  def you_lose_message
    @p.out('You lose.')
  end

  def you_tie_message
    @p.out('You tied.')
  end

  def you_chose (choice)
    @p.out('You chose: ' + choice)
  end

  def comp_chose (choice)
    @p.out('Computer chose: ' + choice)
  end

  def show_scores (u,c)
    @p.out("Your score: #{u}")
    @p.out("Computer's score: #{c}")
  end

  def show_final_message (u,c)
    @p.out('Thanks for playing!')
    @p.out("Final score - YOU: #{u}, COMPUTER: #{c}")
  end

  def show_small_padding
    @p.out('------------------------------------')
  end

  def show_large_padding
    @p.out('------------------------------------')
    @p.out('------------------------------------')
    @p.out('------------------------------------')
  end

end


class Game

  def initialize()
    @presentation = Presentation.new()
    @user_score = 0
    @comp_score = 0
  end

  def start
    @presentation.show_large_padding
    @presentation.show_welcome_message
    loop do
      @presentation.show_small_padding
      @presentation.show_menu
      user_game_choice = gets.chomp
      if user_game_choice == '2'
        if @user_score == 0 && @comp_score == 0
          @presentation.show_small_padding
          @presentation.show_goodbye_message
          @presentation.show_large_padding
        else
          @presentation.show_small_padding
          @presentation.show_final_message(@user_score,@comp_score)
          @presentation.show_large_padding
        end

        break
      elsif user_game_choice == '1'
        user_rps_choice = '0'
        loop do
          @presentation.show_small_padding
          @presentation.show_rps_choices
          user_rps_choice = gets.chomp
          break if user_rps_choice == '1' || user_rps_choice == '2' || user_rps_choice == '3'
          @presentation.show_error_message
        end
        analyze_user_input(user_rps_choice)
        @presentation.show_large_padding
        @presentation.show_scores(@user_score,@comp_score)
      else
        @presentation.show_error_message
      end
    end
  end

  def analyze_user_input (user_choice)
    comp_choice = 1+rand(3)
    user_choice = user_choice.to_i

    comp_choice = convert_to_word(comp_choice)
    user_choice = convert_to_word(user_choice)

    @presentation.show_small_padding
    @presentation.you_chose(user_choice)
    @presentation.comp_chose(comp_choice)

    if user_choice == comp_choice
      @presentation.you_tie_message
    elsif (user_choice == 'Rock' && comp_choice == 'Scissors') || (user_choice == 'Scissors' && comp_choice == 'Paper') || (user_choice == 'Paper' && comp_choice == 'Rock')
      @user_score += 1
      @presentation.you_win_message
    else
      @comp_score += 1
      @presentation.you_lose_message
    end
  end

  def convert_to_word (num)
    case num
    when 1
      'Rock'
    when 2
      'Scissors'
    when 3
      'Paper'
    end
  end

end



class App
  def start
    game = Game.new()
    game.start
  end
end

app = App.new()
app.start
