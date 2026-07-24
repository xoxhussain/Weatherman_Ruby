RED = "\e[31m".freeze
BLUE = "\e[34m".freeze
RESET = "\e[0m".freeze

def avg(array)
  return 0 if array.empty?
  array.sum / array.size
end

MONTHS = [
  "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
]

DATE = 0
MAX_TEMP = 1
MIN_TEMP = 2
MAX_HUMIDITY = 7
MEAN_HUMIDITY = 8

def read_rows(line)
  parts = line.split(",")

  {
    date: parts[DATE],
    max_temp: parts[MAX_TEMP].to_i,
    min_temp: parts[MIN_TEMP].to_i,
    max_humidity: parts[MAX_HUMIDITY].to_i,
    mean_humidity: parts[MEAN_HUMIDITY].to_i
  }
end

def process_files(files)
  files.each do |file|
    File.foreach(file) do |line|
      yield read_rows(line)
    end
  end
end

def get_months(year_month, directory)
  year, month = year_month.split("/")
  month_name = MONTHS[month.to_i - 1]
  files = Dir.glob("#{directory}/**/*#{year}_#{month_name}*.txt")

  [files, year, month_name]
end

def color_result(color, result)
  "#{color}#{result}#{RESET}"
end
