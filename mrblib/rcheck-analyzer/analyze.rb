module RcheckAnalyzer
  def self.run log, total_line, key1, key2=nil, type="count"
    data = []
    analyze = {}
    File.open(log, "r") do |file|
      Tail.new(file).each do |line|
        data << JSON.parse(line)
        if key1 == "keys"
          pp data[0]
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
        if type == "sum"
          if (key2_ary = key2.split(".")).size == 2
            analyze[d[key1]][key2_ary[1]] = 0 if analyze[d[key1]][key2_ary[1]].nil?
            analyze[d[key1]][key2_ary[1]] += d[key2_ary[0]][key2_ary[1]].to_f
          else
            analyze[d[key1]][key2] = 0 if analyze[d[key1]][key2].nil?
            analyze[d[key1]][key2] += d[key2].to_f
          end
        else
          analyze[d[key1]][d[key2]] = 0 if analyze[d[key1]][d[key2]].nil?
          analyze[d[key1]][d[key2]] += 1
        end
      else
        analyze[d[key1]] = 0 if analyze[d[key1]].nil?
        analyze[d[key1]] += 1
      end
    end
    if key2.nil?
      analyze.sort_by {|k, v| v }.reverse.each {|a| puts a }
    else
      analyze.each {|k, v| pp [k, v.sort_by {|k, v| v }.reverse] }
    end
  end
end
