again = "yes"
while again == "yes"
  puts "Do you want to count in seconds, minutes, hours or days?"
  units = gets.chomp
  puts "How many #{units}?"
  amount = gets.chomp.to_i
  again = "same"
  while again == "same"
    start_time = Time.now

    seconds = amount if units == "seconds"
    seconds = amount * 60 if units == "minutes"
    seconds = amount * 60 *60 if units == "hours"
    seconds = amount * 60 *60 * 24 if units == "days"

    while Time.now < start_time + seconds

      sleep 1
      time_left = Time.new(1974)
      time_left_seconds = seconds - (Time.now - start_time)
      time_left += time_left_seconds

      print "\r"
      print time_left.strftime("%H:%M:%S")
    end
    print "\r"
    puts "Your tomato has exploded. Time is up"
    system(%Q{say -v "Vick" "Your tomato has exploded. Time is up"})
    puts %Q{Again? Put "same" for same as before, or "yes" to reenter parameters, anything else for exit.}
    again = gets.chomp
  end
end
