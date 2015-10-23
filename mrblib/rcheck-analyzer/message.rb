module RcheckAnalyzer
  module Message
    def self.output_result analyze, multi_keys

      if multi_keys
        raise ArgumentError, "key1 is invalid argument" if analyze.has_key? nil
        analyze.each do |k, v|
          raise ArgumentError, "key2 is invalid argument" if v.has_key? nil
        end
        analyze.sort do |a, b|
          a[1].to_a.flatten[1] <=> b[1].to_a.flatten[1]
        end.reverse.each {|a| puts a }
      else
        raise ArgumentError, "key1 is invalid argument" if analyze.has_key? nil
        analyze.sort_by {|k, v| v }.reverse.each {|a| puts a }
      end
      analyze
    end
  end
end
