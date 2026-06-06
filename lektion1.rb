# Nu, Pogodi! - Lektion 1
name_wolf = "Wolf 🐺"
name_hase = "Hase 🐇"

puts "Willkommen bei Nu, Pogodi!"
puts "#{name_wolf} jagt #{name_hase}!"
puts "Das Spiel beginnt in..."

3.downto(1) do |i|
  puts "#{i}..."
  sleep 0.5
end

puts "Los geht's!"
