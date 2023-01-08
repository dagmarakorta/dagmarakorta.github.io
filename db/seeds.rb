require 'json/ext'

def build_tags(game)
  tags = []
  tags += game["genres"]&.map { |element| element["name"].downcase }&.uniq || []
  tags += game["themes"]&.map { |element| element["name"].downcase }&.uniq || []
  tags += game["keywords"]&.map { |element| element["name"].downcase }&.uniq || []
  tags
end

def should_skip(game, tags)
  [
    game["screenshots"],
    game["videos"],
    game["aggregated_rating"],
    game["cover"],
    tags
  ].any?(&:blank?)
end

unless User.find_by_email("test@test.com")
  User.create(
    username: "Test",
    email: "test@test.com",
    password: "secret"
  )
  puts "*******************************************************"
  puts "Created test user with following credentials:"
  puts "test@test.com"
  puts "secret"
end

puts "*******************************************************"
puts "Destroying all games..."
start = Time.now
Game.destroy_all
puts "Done in #{Time.now - start}s"

puts "*******************************************************"
puts "Parsing games..."
start = Time.now
if Rails.env == "production"
  games = JSON.load_file(File.join(__dir__, "seeds/data/heroku_games.json"))
else
  games = JSON.load_file(File.join(__dir__, "seeds/data/games_first_half.json"))
  games += JSON.load_file(File.join(__dir__, "seeds/data/games_second_half.json"))
end
puts "Done in #{Time.now - start}s"

puts "*******************************************************"
n = 0
skipped = 0
puts "Creating games..."
start = Time.now
print "Created games: 0"
games.each do |game|
  tags = build_tags(game)
  if should_skip(game, tags)
    skipped += 1
    next
  end
  Game.create(
    name: game["name"],
    summary: game["summary"],
    screenshots: game["screenshots"]&.map { |s| s["url"]&.prepend("https:")&.sub("t_thumb", "t_1080p") },
    videos: game["videos"]&.map { |v| "https://www.youtube.com/embed/#{v['video_id']}" },
    cover: game&.dig("cover", "url")&.prepend("https:")&.sub("t_thumb", "t_1080p"),
    platforms: game["platforms"]&.pluck("name"),
    rating: game["aggregated_rating"],
    release_date: game.key?("first_release_date") ? Time.at(game["first_release_date"]).to_datetime : nil,
    developer: game["involved_companies"]&.find { |company| company["developer"] }&.dig("company", "name"),
    franchise: game&.dig("franchise", "name"),
    franchises: game&.dig("franchises")&.pluck("name"),
    game_modes: game["game_modes"]&.pluck("name"),
    genres: game&.dig("genres")&.pluck("name") || [],
    themes: game&.dig("themes")&.pluck("name") || [],
    tags: tags,
    slug: game["slug"],
    stores: game["stores"]
  )
  n += 1
  print "\rCreated games: #{n.to_s.rjust(5)}"
end
puts "\nSkipped games: #{skipped}"
puts "Done in #{Time.now - start}s"
