again = "yes"
@voice = "Vicki"
phrase = "Your tomato has exploded. Time is up"

def voice_sample
  `say -v ?`.split(/\n/).map { |l| l[0, l.index('en_')].strip }.each { |v| puts v; %x[say -v \"#{v}\" \"I am #{v}\"]; sleep(0.5) }
  puts "Please choose a voice."
  @voice = gets.chomp
end

while again == "yes"
  while true
    puts %Q{Do you want to choose the voice or phrase for timer ending?}
    puts %Q{Put "voice", "phrase" or "both" to choose both. Anything else for no}
    choosy = gets.chomp
    case choosy
      when "voice"
        puts %Q{What voice would you like to choose? If you want a list and sample, put "help"}
        @voice = gets.chomp
        voice_sample if @voice == "help"
      when "phrase"
        puts "What phrase would you like to choose?"
        phrase = gets.chomp
      when "both"
        puts %Q{What voice would you like to choose? If you want a list and sample, put "help"}
        @voice = gets.chomp
        voice_sample if @voice == "help"
        puts "What phrase would you like to choose?"
        phrase = gets.chomp
    end
    puts "Do you want to count in seconds, minutes, hours or days?"
    units = gets.chomp
    if units == "seconds" ||
      units == "minutes" ||
      units == "hours" ||
      units == "days"
      puts "How many #{units}?"
      amount = gets.chomp.to_i
    else
      puts "I don't understand"
    end
    break
  end
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
    puts "00:00:00"
    puts phrase
    system(%Q{say -v #{@voice} #{phrase}})
    puts %Q{Again? Put "same" for same as before, or "yes" to reenter parameters, anything else for exit.}
    again = gets.chomp
  end
end
