require './robot/bras_droit'
require './robot/bras_gauche'

class Robot

  def initialize
    @pieces = [BrasGauche.new]
    # @pieces = [BrasDroit.new, BrasGauche.new]
  end

  def hello
    execute_move('hello')
  end

  def danse
    execute_move('danse')
  end

  def reset
    execute_move('reset')
  end

  def kung_fu
    execute_move('kung_fu')
  end

  def masturbation
    execute_move('masturbation')
  end

  def pasvoir
    execute_move('pasvoir')
  end

  private

  def execute_move(move)
    threads = []
    @pieces.each do |piece|
      threads << Thread.new { piece.send(move) }
    end
    threads.each { |thrd| thrd.join }
  end

end


