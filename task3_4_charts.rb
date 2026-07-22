RED = "\e[31m"
BLUE = "\e[34m"
RESET = "\e[0m"

def double_chart(year_month, directory)
  files, year, month_name = get_months(year_month, directory)
  return puts "No data found." if files.empty?

  files.each do |file|
    File.foreach(file) do |line|
      data = read_rows(line)
      day = data[:date].split("-")[2]
      max_chart = "#{RED}#{'+' * data[:max_temp]}#{RESET}"
      puts "#{day} #{max_chart} #{data[:max_temp]}C"

      min_chart = "#{BLUE}#{'+' * data[:min_temp]}#{RESET}"
      puts "#{day} #{min_chart} #{data[:min_temp]}"
    end
  end
end

def single_line(year_month, directory)
  files, year, month_name = get_months(year_month, directory)
  return puts "No data found." if files.empty?
  files.each do |file|
    File.foreach(file) do |line|
      data = read_rows(line)
      day = data[:date].split("-")[2]
      max_min_chart = "#{BLUE}#{"+" * data[:min_temp]}#{RESET}#{RED}#{"+" * (data[:max_temp] - data[:min_temp])}#{RESET}"
      puts "#{day} #{max_min_chart} #{data[:min_temp]}C - #{data[:max_temp]}C"
    end
  end
end
