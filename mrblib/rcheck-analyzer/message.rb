module RcheckAnalyzer
  module Message
    def self.output_result analyze, multi_keys
      if multi_keys
        analyze.each {|k, v| pp [k, v.sort_by {|k, v| v }.reverse] }
      else
        analyze.sort_by {|k, v| v }.reverse.each {|a| puts a }
      end
    end
  end
end
