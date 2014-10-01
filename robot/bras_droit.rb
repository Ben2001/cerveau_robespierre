require 'net/http'

#bras droit
# IP Fixe: 10.0.0.32
# angle lever 20 ->  100 repos 20
# rotation 90 -> 160 repos 90
# coude 150 -> 60 repos 150
# main 0 -> 180


# Need to adapt
class BrasDroit
  BRAS="10.0.0.32"
  attr_reader :delay, :appel_moteur

  def initialize
    @delay = "2000"
    @appel_moteur = "070"
  end

  def danse
    @delay = "0500"
    call_bras("/a020-090-070-090-#{delay}-#{appel_moteur}")
    5.times {
      send("seq_#{(rand(100) % 2) + 1}")
    }
    reset
  end

  def hello
    call_bras("/a090-020-090-090-090-#{delay}-#{appel_moteur}")
    @delay = "0500"
    5.times {
      call_bras("/a090-070-150-090-090-#{delay}-#{appel_moteur}")
      call_bras("/a090-070-150-060-000-#{delay}-#{appel_moteur}")
    }
    reset
  end

  def reset
    call_bras("/a090-020-090-150-090-#{delay}-#{appel_moteur}")
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
    # response `curl http://10.0.0.32`
    puts response
  end
end

