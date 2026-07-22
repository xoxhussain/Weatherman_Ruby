option = ARGV[0]
year = ARGV[1]
directory = ARGV[2]

def avg(array)
  array.sum / array.size
end

def print_highest_data(highest_temp, lowest_temp, highest_humidity)
  puts "Highest: #{highest_temp[:val]}°C on #{highest_temp[:date]}"
  puts "Lowest: #{lowest_temp[:val]}°C on #{lowest_temp[:date]}"
  puts "Humidity: #{highest_humidity[:val]}% on #{highest_humidity[:date]}"
end

def read_rows(line)
  parts = line.split(",")

  {
    date: parts[0],
    max_temp: parts[1].to_i,
    min_temp: parts[2].to_i,
    max_humidity: parts[7].to_i,
    mean_humidity: parts[8].to_i
  }
end

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
  files.each do |file|
    File.foreach(file) do |line|
      data = read_rows(line)
      update_stats(data, highest_temp, lowest_temp, highest_humidity)
    end
  end
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

def collect_monthly_data(files)
  max_temps = []
  min_temps = []
  humidities = []

  files.each do |file|
    File.foreach(file) do |line|
      data = read_rows(line)

      max_temps << data[:max_temp]
      min_temps << data[:min_temp]
      humidities << data[:mean_humidity]
    end
  end

  [max_temps, min_temps, humidities]
end

def print_monthly_stats(max_temps, min_temps, humidities)
  puts "Monthly Report"
  puts "Highest Average: #{avg(max_temps)}°C"
  puts "Lowest Average: #{avg(min_temps)}°C"
  puts "Average Humidity: #{avg(humidities)}%"
end

def monthly_stats(year_month, directory)
  files = Dir.glob("#{directory}/**/*#{year_month}*.txt")
  return puts("No data found.") if files.empty?

  max_temps, min_temps, humidities = collect_monthly_data(files)
  print_monthly_stats(max_temps, min_temps, humidities)
end

case option
when "-e"
  yearly_stats(year, directory)
when "-a"
  monthly_stats(year, directory)
when "-c"
  double_chart(year, directory)
when "-s"
  single_line(year, directory)
else
  puts "Invalid options."
end
