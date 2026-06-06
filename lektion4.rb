# Nu, Pogodi! - Lektion 4: Klassen

BREITE = 20

class Figur
  attr_reader :pos, :symbol

  def initialize(symbol, startpos)
    @symbol = symbol
    @pos = startpos
  end

  def bewege(richtung)
    neue_pos = @pos + richtung
    @pos = neue_pos if neue_pos >= 0 && neue_pos < BREITE
  end
end

class Wolf < Figur
  def jage!(ziel)
    richtung = ziel.pos > @pos ? 1 : -1
    bewege(richtung)
  end
end

class Hase < Figur
  def huepfe!(taste)
    case taste
    when "a" then bewege(-1)
    when "d" then bewege(1)
    end
  end
end

# Kurze Demo
wolf = Wolf.new("🐺", 0)
hase = Hase.new("🐇", BREITE - 1)

puts "Wolf startet bei: #{wolf.pos}"
puts "Hase startet bei: #{hase.pos}"

3.times do
  wolf.jage!(hase)
  puts "Wolf bewegt sich → Position: #{wolf.pos}"
end
