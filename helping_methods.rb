def avg(array)
  array.sum / array.size
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

def get_months(year_month, directory)
  months = [
    "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
  ]
  year, month = year_month.split("/")
  month_name = months[month.to_i - 1]
  files = Dir.glob("#{directory}/**/*#{year}_#{month_name}*.txt")

  [files, year, month_name]
end

