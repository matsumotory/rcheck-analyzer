module RcheckAnalyzer
  def self.run log, total_line, key
    data = []
    analyze = {}
    File.open(log, "r") do |file|
      Tail.new(file).each do |line|
        data << JSON.parse(line)
        break if data.size > total_line
      end
    end
    data.each do |d|
      analyze[d[key]] = 0 if analyze[d[key]].nil?
      analyze[d[key]] += 1
    end
    analyze.sort_by {|k, v| v }.each { |a| puts a }
  end
end
