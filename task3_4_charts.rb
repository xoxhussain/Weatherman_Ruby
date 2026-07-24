def double_chart(year_month, directory)
  files, year, month_name = get_months(year_month, directory)
  return puts "No data found." if files.empty?

  process_files(files) do |data|
    day = data[:date].split("-")[2]
    max_chart = color_result(RED, "+" * data[:max_temp])
    puts "#{day} #{max_chart} #{data[:max_temp]}C"

    min_chart = color_result(BLUE, "+" * data[:min_temp])
    puts "#{day} #{min_chart} #{data[:min_temp]}"
  end
end

def single_line(year_month, directory)
  files, year, month_name = get_months(year_month, directory)
  return puts "No data found." if files.empty?

  process_files(files) do |data|
    day = data[:date].split("-")[2]
    max_min_chart = color_result(BLUE, "+" * data[:min_temp]) + color_result(RED, "+" * (data[:max_temp] - data[:min_temp]))
    puts "#{day} #{max_min_chart} #{data[:min_temp]}C - #{data[:max_temp]}C"
  end
end
