# db/seeds.rb

# Load each seed file in the seeds directory
Dir[File.join(Rails.root, 'db', 'seeds', '*', '*.rb')].sort.each do |seed_file|
    puts "Seeding #{File.basename(seed_file)}..."
    load seed_file
  end
  
  puts "All seeds are loaded!"
  