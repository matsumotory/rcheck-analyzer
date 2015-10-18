module RcheckAnalyzer
  module Message
    def self.output_result analyze, multi_keys
      raise ArgumentError, "invalid argument\n#{Error::USAGE}" if analyze.has_key? nil

      if multi_keys
        analyze.each {|k, v| pp [k, v.sort_by {|k, v| v }.reverse] }
      else
        analyze.sort_by {|k, v| v }.reverse.each {|a| puts a }
      end
      analyze
    end
  end
end
