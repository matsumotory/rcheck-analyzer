module RcheckAnalyzer
  def self.run log, total_line, key1, key2=nil
    data = []
    analyze = {}
    File.open(log, "r") do |file|
      Tail.new(file).each do |line|
        data << JSON.parse(line)
        if key1 == "keys"
          pp data[0].keys
          return
        end
        break if data.size > total_line
      end
    end
    data.each do |d|
      unless key2.nil?
        if analyze[d[key1]].nil?
          analyze[d[key1]] = {}
        end
        analyze[d[key1]][d[key2]] = 0 if analyze[d[key1]][d[key2]].nil?
        analyze[d[key1]][d[key2]] += 1
      else
        analyze[d[key1]] = 0 if analyze[d[key1]].nil?
        analyze[d[key1]] += 1
      end
    end
    if key2.nil?
      analyze.sort_by {|k, v| v }.each {|a| puts a }
    else
      analyze.each {|k, v| puts [k, v] }
    end
  end
end
