require 'net/http'

#bras gauche
# IP Fixe: 10.0.0.31
# angle lever 158 ->  60 repos 158
# rottion 20 -> 160 repos 90
# coude 20 -> 125 repos 20
# main 0 -> 180
#
# sur 3 charvec - entre. - temps en millisecond sur 4 chiffres - 3 char etapes.
#
# /p pour un hello simple...


class BrasGauche
  BRAS="10.0.0.31"
  attr_reader :delay, :appel_moteur

  def initialize
    @delay = "0500"
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
    call_bras("/a090-110-090-100-000-#{delay}-#{appel_moteur}")
    @delay = "0500"
    call_bras("/a090-110-020-110-180-#{delay}-#{appel_moteur}")
    call_bras("/a090-090-020-070-000-#{delay}-#{appel_moteur}")
    call_bras("/a090-090-020-110-050-#{delay}-#{appel_moteur}")
    call_bras("/a090-090-020-070-050-#{delay}-#{appel_moteur}")
    call_bras("/a090-090-020-110-050-#{delay}-#{appel_moteur}")
    call_bras("/a090-090-020-100-050-#{delay}-#{appel_moteur}")
    call_bras("/a090-090-020-100-000-#{delay}-#{appel_moteur}")
    call_bras("/a090-090-020-100-180-#{delay}-#{appel_moteur}")
    call_bras("/a090-090-020-100-000-#{delay}-#{appel_moteur}")
    call_bras("/a090-090-020-100-180-#{delay}-#{appel_moteur}")
    call_bras("/a090-090-020-100-180-#{delay}-#{appel_moteur}")
    call_bras("/a090-090-020-100-000-#{delay}-#{appel_moteur}")
    call_bras("/a090-090-020-100-000-#{delay}-#{appel_moteur}")
    reset
  end

  def reset
    call_bras("/a090-158-090-020-000-#{delay}-#{appel_moteur}")
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

  def kung_fu
    call_bras("/a135-158-120-120-000-#{delay}-#{appel_moteur}")
    call_bras("/a135-120-120-100-090-#{delay}-#{appel_moteur}")
    sleep 1
    reset
  end

  def masturbation
    @delay = '0350'
    5.times {
    call_bras("/a130-140-125-110-180-#{delay}-#{appel_moteur}")
    call_bras("/a130-140-160-100-180-#{delay}-#{appel_moteur}")
    }
    reset
  end

  def pasvoir
    call_bras("/a185-158-120-110-180-#{delay}-#{appel_moteur}")
    sleep 2
    reset
  end

  def call_bras(uri)
    puts uri
    response = Net::HTTP.get("#{BRAS}", uri)
    # response = `curl http://10.0.0.31`
    puts response
  end

end

