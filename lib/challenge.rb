require 'time'
# challenge solution to find latest and earliest date from file
class Challenge
  attr_reader :earliest_time, :latest_time, :peak_year

  def initialize(file_path)
    @file_path = File.expand_path(file_path)
  end

  def parse
    @hash_of_years = {}
    File.open(@file_path, 'r') do |f|
      @earliest_time = Time.parse(f.first)
      @latest_time = @earliest_time
      f.each_line do |line|
        find_earliest_latest_date_and_year(line)
      end
    end
    @peak_year = @hash_of_years.key(@hash_of_years.values.max).to_s.to_i
  end

  def find_earliest_latest_date_and_year(line)
    parsed_time = Time.parse(line)
    @earliest_time = @earliest_time < parsed_time ? @earliest_time : parsed_time
    @latest_time = @latest_time > parsed_time ? @latest_time : parsed_time
    year = parsed_time.year
    if @hash_of_years.key?(:"#{year}")
      @hash_of_years[:"#{year}"] += 1
    else
      @hash_of_years.merge!("#{year}": 1)
    end
  end
end
