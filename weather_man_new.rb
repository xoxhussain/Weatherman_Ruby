require_relative "helping_methods"
require_relative "task1_year"
require_relative "task2_month"
require_relative "task3_4_charts"

option = ARGV[0]
year = ARGV[1]
directory = ARGV[2]


case option
when "-e"
  yearly_stats(year, directory)
when "-a"
  monthly_average(year, directory)
when "-c"
  double_chart(year, directory)
when "-s"
  single_line(year, directory)
else
  puts "Invalid options."
end
