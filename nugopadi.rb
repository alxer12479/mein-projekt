# Nu, Pogodi! - Das fertige Spiel 🐺🐇
require 'io/console'

BREITE = 22

class Figur
  attr_reader :pos, :symbol

  def initialize(symbol, startpos)
    @symbol   = symbol
    @pos      = startpos
  end

  def bewege(richtung)
    neue_pos = @pos + richtung
    @pos = neue_pos if neue_pos >= 0 && neue_pos < BREITE
  end
end

class Wolf < Figur
  def initialize
    super("🐺", 0)
    @geschwindigkeit = 1
  end

  def jage!(ziel, zug)
    # Wolf wird alle 10 Züge schneller
    @geschwindigkeit = 1 + (zug / 10)
    @geschwindigkeit.times { richtung = ziel.pos > @pos ? 1 : -1; bewege(richtung) }
  end

  def reset!
    @pos = 0
  end
end

class Hase < Figur
  def initialize
    super("🐇", BREITE - 1)
  end

  def huepfe!(taste)
    case taste
    when "a" then bewege(-2)
    when "d" then bewege(2)
    end
  end

  def reset!
    @pos = BREITE - 1
  end
end

class Spiel
  HIGHSCORE_DATEI = "highscore.txt"

  def initialize
    @wolf   = Wolf.new
    @hase   = Hase.new
    @punkte = 0
    @leben  = 3
    @zug    = 0
    @highscore = lade_highscore
  end

  def starte
    intro
    loop do
      zeichne
      taste = $stdin.getch
      break if taste == "q"

      @hase.huepfe!(taste)
      @wolf.jage!(@hase, @zug)
      @punkte += 1
      @zug    += 1

      if @wolf.pos == @hase.pos
        @leben -= 1
        if @leben <= 0
          game_over
          break
        else
          system("clear")
          puts "🐺 Erwischt! Noch #{@leben} ❤️  — weiter in 1 Sekunde..."
          sleep 1
          @wolf.reset!
          @hase.reset!
        end
      end
    end
    speichere_highscore
  end

  private

  def intro
    system("clear")
    puts "╔══════════════════════════╗"
    puts "║     НУ, ПОГОДИ!          ║"
    puts "║     Nu, Pogodi!  🐺🐇    ║"
    puts "╚══════════════════════════╝"
    puts ""
    puts "Highscore: #{@highscore}"
    puts ""
    puts "[a] = 2 Schritte links"
    puts "[d] = 2 Schritte rechts"
    puts "[q] = beenden"
    puts ""
    puts "Drücke eine Taste zum Starten..."
    $stdin.getch
  end

  def zeichne
    system("clear")
    feld = Array.new(BREITE, "·")
    feld[@wolf.pos] = @wolf.symbol
    feld[@hase.pos] = @hase.symbol
    level = 1 + (@zug / 10)
    puts "Nu, Pogodi! | Punkte: #{@punkte} | Leben: #{"❤️ " * @leben}| Level: #{level}"
    puts "Highscore: #{@highscore}"
    puts "+" + "──" * BREITE + "+"
    puts "|" + feld.join("") + "|"
    puts "+" + "──" * BREITE + "+"
    puts "[a] links  [d] rechts  [q] beenden"
  end

  def game_over
    system("clear")
    puts "╔══════════════════════════╗"
    puts "║       GAME OVER  💀      ║"
    puts "╚══════════════════════════╝"
    puts ""
    puts "Punkte:     #{@punkte}"
    puts "Highscore:  #{[@punkte, @highscore].max}"
    puts ""
    puts "Nu pogodi bedeutet: 'Na warte!'  😄"
  end

  def lade_highscore
    File.exist?(HIGHSCORE_DATEI) ? File.read(HIGHSCORE_DATEI).to_i : 0
  end

  def speichere_highscore
    if @punkte > @highscore
      File.write(HIGHSCORE_DATEI, @punkte.to_s)
      puts "🏆 Neuer Highscore: #{@punkte}!"
    end
  end
end

Spiel.new.starte
