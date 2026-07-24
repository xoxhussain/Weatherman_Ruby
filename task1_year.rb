def update_stats(data, highest_temp, lowest_temp, highest_humidity)
  if data[:max_temp] > highest_temp[:val]
    highest_temp[:val] = data[:max_temp]
    highest_temp[:date] = data[:date]
  end
  if data[:min_temp] < lowest_temp[:val]
    lowest_temp[:val] = data[:min_temp]
    lowest_temp[:date] = data[:date]
  end
  if data[:max_humidity] > highest_humidity[:val]
    highest_humidity[:val] = data[:max_humidity]
    highest_humidity[:date] = data[:date]
  end
end

def process_yearly_file(files, highest_temp, lowest_temp, highest_humidity)
  process_files(files) do |data|
    update_stats(data, highest_temp, lowest_temp, highest_humidity)
  end
end

def print_highest_data(highest_temp, lowest_temp, highest_humidity)
  puts "Highest: #{highest_temp[:val]}°C on #{highest_temp[:date]}"
  puts "Lowest: #{lowest_temp[:val]}°C on #{lowest_temp[:date]}"
  puts "Humidity: #{highest_humidity[:val]}% on #{highest_humidity[:date]}"
end

def yearly_stats(year, directory)
  files = Dir.glob("#{directory}/**/*#{year}*.txt")
  return puts "No data found." if files.empty?

  highest_temp = { val: -100, date: nil }
  lowest_temp = { val: 100, date: nil }
  highest_humidity = { val: -1, date: nil }

  process_yearly_file(files, highest_temp, lowest_temp, highest_humidity)

  print_highest_data(highest_temp, lowest_temp, highest_humidity)
end
