module RcheckAnalyzer
  class Analyze
    def initialize log, total_line, key1, key2=nil, type="count"
      @log = log
      @total_line = total_line
      @key1 = key1.downcase
      @key2 = (key2.nil?) ? key2 : key2.downcase
      @type = (type.nil?) ? type : type.downcase
      if @type == "sum"
        if (@key2_ary = @key2.split(".")).size != 2
          @key2_ary = nil
        end
      end
    end

    def data_from_log log
      data = []
      File.open(log, "r") do |file|
        unless log == "/proc/self/fd/0"
          fp = Tail.new file
        else
          fp = file
        end
        fp.each do |line|
          data << JSON.parse(line.downcase)
          if @key1 == "keys"
            pp data[0]
            return nil
          end
          break if @total_line != 0 and data.size > @total_line
        end
      end
      data
    end

    def analyze_data data
      analyze = {}
      data.each do |d|
        if @key2.nil?
          analyze[d[@key1]] = 0 if analyze[d[@key1]].nil?
          analyze[d[@key1]] += 1
        else
          analyze[d[@key1]] = {} if analyze[d[@key1]].nil?
          if @type == "sum"
            if @key2_ary.nil?
              analyze[d[@key1]][@key2] = 0 if analyze[d[@key1]][@key2].nil?
              analyze[d[@key1]][@key2] += d[@key2].to_f
            else
              analyze[d[@key1]][@key2_ary[1]] = 0 if analyze[d[@key1]][@key2_ary[1]].nil?
              analyze[d[@key1]][@key2_ary[1]] += d[@key2_ary[0]][@key2_ary[1]].to_f
            end
          else
            analyze[d[@key1]][d[@key2]] = 0 if analyze[d[@key1]][d[@key2]].nil?
            analyze[d[@key1]][d[@key2]] += 1
          end
        end
      end
      analyze
    end

    def run
      @log = "/proc/self/fd/0" if @log == "stdin" or @log == "self"

      data = data_from_log @log
      return if data.nil?
      result = analyze_data data
      output_result result
    end

    def output_result analyze
      if @key2.nil?
        analyze.sort_by {|k, v| v }.reverse.each {|a| puts a }
      else
        analyze.each {|k, v| pp [k, v.sort_by {|k, v| v }.reverse] }
      end
    end

  end
end
