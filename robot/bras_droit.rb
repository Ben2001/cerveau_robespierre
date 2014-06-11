require 'net/http'

#bras droit
# angle lever 20 ->  100 repos 20
# rotation 90 -> 160 repos 90
# coude 150 -> 60 repos 150
# main 0 -> 180


# Need to adapt
class BrasDroit
  BRAS="192.168.2.178"
  attr_reader :delay, :appel_moteur

  def initialize
    @delay = "2000"
    @appel_moteur = "070"
  end

  def danse
    @delay = "0500"
    call_bras("/a158-090-100-000-#{delay}-#{appel_moteur}")
    5.times {
      send("seq_#{(rand(100) % 2) + 1}")
    }
    reset
  end

  def hello
    call_bras("/droit-a110-090-100-000-#{delay}-#{appel_moteur}")
    @delay = "0500"
    call_bras("/droit-a110-020-110-180-#{delay}-#{appel_moteur}")
    call_bras("/droit-a090-020-070-000-#{delay}-#{appel_moteur}")
    call_bras("/droit-a090-020-110-050-#{delay}-#{appel_moteur}")
    call_bras("/droit-a090-020-100-000-#{delay}-#{appel_moteur}")
    call_bras("/droit-a090-020-100-180-#{delay}-#{appel_moteur}")
    call_bras("/droit-a090-020-100-180-#{delay}-#{appel_moteur}")
    call_bras("/droit-a090-020-100-000-#{delay}-#{appel_moteur}")
    call_bras("/droit-a090-020-100-000-#{delay}-#{appel_moteur}")
    reset
  end

  def reset
    call_bras("/a158-090-020-000-#{delay}-#{appel_moteur}")
  end

  private

  def seq_1
    call_bras("/a158-050-100-150-#{delay}-#{appel_moteur}")
    call_bras("/a108-050-100-075-#{delay}-#{appel_moteur}")
    call_bras("/a108-110-100-050-#{delay}-#{appel_moteur}")
    call_bras("/a158-090-100-000-#{delay}-#{appel_moteur}")
  end

  def seq_2
    call_bras("/a158-050-100-150-#{delay}-#{appel_moteur}")
    call_bras("/a108-110-100-050-#{delay}-#{appel_moteur}")
  end

  def call_bras(uri)
    puts uri
    response = Net::HTTP.get("#{BRAS}", uri)
    puts response
  end
end
