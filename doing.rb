require 'net/http'

# angle lever 158 ->  60 repos 158
# rottion 20 -> 160 repos 90
# coude 20 -> 125 repos 20
# main 0 -> 180
#
# sur 3 charvec - entre. - temps en millisecond sur 4 chiffres - 3 char etapes.
#
# /p pour un hello simple...


class Doing
  BRAS="192.168.2.178"
  attr_reader :delay

  def danse
    @delay = "0500"
    call_bras("/a158-090-100-000-#{delay}-070")
    5.times {
      send("seq_#{(rand(100) % 2) + 1}")
    }
    call_bras("/r")
  end

  def hello
    call_bras("/a110-090-100-000-2000-070")
    call_bras("/a110-020-110-180-0500-070")
    call_bras("/a090-020-070-000-0500-070")
    call_bras("/a090-020-110-050-0500-070")
    call_bras("/a090-020-070-050-0500-070")
    call_bras("/a090-020-110-050-0500-070")
    call_bras("/a090-020-100-050-0500-070")
    call_bras("/a090-020-100-000-0500-070")
    call_bras("/a090-020-100-180-0500-070")
    call_bras("/a090-020-100-000-0500-070")
    call_bras("/a090-020-100-180-0500-070")
    call_bras("/a090-020-100-180-0500-070")
    call_bras("/a090-020-100-000-0500-070")
    call_bras("/a090-020-100-000-0500-070")
    call_bras("/r")
  end

  def reset
    call_bras("/r")
  end

  private

  def seq_1
    call_bras("/a158-050-100-150-#{delay}-070")
    call_bras("/a108-050-100-075-#{delay}-070")
    call_bras("/a108-110-100-050-#{delay}-070")
    call_bras("/a158-090-100-000-#{delay}-070")
  end

  def seq_2
    call_bras("/a158-050-100-150-#{delay}-070")
    call_bras("/a108-110-100-050-#{delay}-070")
  end

  def call_bras(uri)
    response = Net::HTTP.get("#{BRAS}", uri)
  end
end

