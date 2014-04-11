puts "Do you want to count in seconds, minutes, hours or days?"
units = gets.chomp
puts "How many #{units}?"
amount = gets.chomp.to_i
start_time = Time.now

seconds = amount if units == "seconds"
seconds = amount * 60 if units == "minutes"
seconds = amount * 60 *60 if units == "hours"
seconds = amount * 60 *60 * 24 if units == "days"

while true
  if Time.now > start_time + seconds
    system(%Q{say -v "Vick" "Your tomato has exploded. Time is up"})
    exit
  end
  sleep 1
end

