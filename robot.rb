require './robot/bras_droit'
require './robot/bras_gauche'

class Robot

  def initialize
    @pieces = [BrasDroit.new, BrasGauche.new]
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

  private

  def execute_move(move)
    threads = []
    @pieces.each do |piece|
      threads << Thread.new { piece.send(move) }
    end
    threads.each { |thrd| thrd.join }
  end

end


