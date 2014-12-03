def voice_sample
  `say -v ?`.split(/\n/).map { |l| l[0, l.index('  ')].strip }.each { |v| puts v; %x[say -v \"#{v}\" \"I am #{v}\"]; sleep(0.5) }
end

def collect_inputs
  puts %Q{Do you want to choose the voice for timer ending (y or n)?}
  choose_voice = (gets.chomp == "y")

  if choose_voice
    puts %Q{What voice would you like to choose? If you want a list and sample, put "help"}
    voice = gets.chomp
    if voice == "help"
      voice_sample
      puts "Please choose a voice."
      voice = gets.chomp
    end
  else
    voice = "Vicki"
  end

  puts %Q{Do you want to choose the phrase for timer ending (y or n)?}
  choose_phrase = (gets.chomp == "y")

  if choose_phrase
    puts "What phrase would you like to choose?"
    phrase = gets.chomp
  else
    phrase = "Your tomato has exploded. Time is up"
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
    puts "I don't understand the units #{units}, please try run_again."
    exit(1)
  end

  {:voice => voice, :phrase => phrase, :units => units, :amount => amount}
end

def calculate_seconds(amount, units)
  if units == "seconds"
    amount
  elsif units == "minutes"
    amount * 60
  elsif units == "hours"
    amount * 60 *60
  else
    amount * 60 *60 * 24
  end
end

def run_again?
  puts %Q{Again? y or n}
  gets.chomp == 'y'
end

def same_inputs?
  puts %Q{Use the same inputs voice, phrase and time? y or n}
  gets.chomp == 'y'
end

def output_time_left(seconds, start_time)
  time_left = Time.new(1974)
  time_left_seconds = seconds - (Time.now - start_time)
  time_left += time_left_seconds
  print "\r"
  print time_left.strftime("%H:%M:%S")
end

def output_ending(voice, phrase)
  print "\r"
  puts "00:00:00"
  puts phrase
  system(%Q{say -v #{voice} #{phrase}})
end

run_again = true
same_inputs = false

while run_again
  user_input = nil if !user_input

  if !same_inputs
    user_input = collect_inputs
  end

  start_time = Time.now

  seconds = calculate_seconds(user_input[:amount], user_input[:units])

  while Time.now < start_time + seconds
    sleep 1
    output_time_left(seconds, start_time)
  end

  output_ending(user_input[:voice], user_input[:phrase])

  run_again = run_again?

  if run_again
    same_inputs = same_inputs?
  end
end
