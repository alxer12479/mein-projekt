# Nu, Pogodi! - Lektion 5: Kollision & Spiellogik
require 'io/console'

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

def zeichne(wolf, hase, punkte, leben)
  system("clear")
  feld = Array.new(BREITE, ".")
  feld[wolf.pos] = wolf.symbol
  feld[hase.pos] = hase.symbol
  puts "Nu, Pogodi! | Punkte: #{punkte} | Leben: #{"❤️ " * leben}"
  puts "+" + "-" * BREITE + "+"
  puts "|" + feld.join("") + "|"
  puts "+" + "-" * BREITE + "+"
  puts "[a] links  [d] rechts  [q] beenden"
end

wolf  = Wolf.new("🐺", 0)
hase  = Hase.new("🐇", BREITE - 1)
punkte = 0
leben  = 3

while leben > 0
  zeichne(wolf, hase, punkte, leben)
  taste = $stdin.getch

  break if taste == "q"

  hase.huepfe!(taste)
  wolf.jage!(hase)
  punkte += 1

  if wolf.pos == hase.pos
    leben -= 1
    puts leben > 0 ? "🐺 Erwischt! Noch #{leben} Leben..." : "💀 Game Over! Punkte: #{punkte}"
    sleep 1
    wolf  = Wolf.new("🐺", 0)
    hase  = Hase.new("🐇", BREITE - 1)
  end
end
