# Nu, Pogodi! - Lektion 3: Eingabe & Steuerung
require 'io/console'

BREITE = 20

def zeichne_feld(wolf_pos, hase_pos, punkte)
  system("clear")
  feld = Array.new(BREITE, ".")
  feld[wolf_pos] = "🐺"
  feld[hase_pos] = "🐇"
  puts "Nu, Pogodi! | Punkte: #{punkte}"
  puts "+" + "-" * BREITE + "+"
  puts "|" + feld.join("") + "|"
  puts "+" + "-" * BREITE + "+"
  puts "Steuerung: [a] links  [d] rechts  [q] beenden"
end

wolf = 0
hase = BREITE - 1
punkte = 0
running = true

while running
  zeichne_feld(wolf, hase, punkte)
  
  taste = $stdin.getch
  
  case taste
  when "a"
    hase -= 1 unless hase <= 0
  when "d"
    hase += 1 unless hase >= BREITE - 1
  when "q"
    running = false
    next
  end
  
  # Wolf bewegt sich automatisch auf Hasen zu
  wolf += wolf < hase ? 1 : -1
  punkte += 1
  
  if wolf == hase
    zeichne_feld(wolf, hase, punkte)
    puts "🐺 Erwischt! Game Over nach #{punkte} Zügen!"
    running = false
  end
end
