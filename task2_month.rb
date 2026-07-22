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

def print_monthly_stats(max_temps, min_temps, humidities, month_name, year)
  puts "Monthly Report for #{month_name}, #{year}"
  puts "Highest Average: #{avg(max_temps)}°C"
  puts "Lowest Average: #{avg(min_temps)}°C"
  puts "Average Humidity: #{avg(humidities)}%"
end

def monthly_average(year_month, directory)
  files, year, month_name = get_months(year_month, directory)
  return puts "No data found." if files.empty?
  max_temps, min_temps, humidities = collect_monthly_data(files)
  print_monthly_stats(max_temps, min_temps, humidities, month_name, year)
end
