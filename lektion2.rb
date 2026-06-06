# Nu, Pogodi! - Lektion 2: Das Spielfeld

BREITE = 20

def zeichne_feld(wolf_pos, hase_pos)
  system("clear")
  feld = Array.new(BREITE, ".")
  feld[wolf_pos] = "🐺"
  feld[hase_pos] = "🐇"
  puts "+" + "-" * BREITE + "+"
  puts "|" + feld.join("") + "|"
  puts "+" + "-" * BREITE + "+"
  puts "Wolf: #{wolf_pos} | Hase: #{hase_pos}"
end

wolf = 0
hase = BREITE - 1

5.times do
  zeichne_feld(wolf, hase)
  wolf += 1
  hase -= 1
  sleep 0.5
end

puts "Wolf fängt den Hasen... bald! 😈"
