module RcheckAnalyzer
  module Message
    def self.output_result analyze, multi_keys

      if multi_keys
        raise ArgumentError, "key1 is invalid argument\n#{Error::USAGE}" if analyze.has_key? nil
        analyze.each do |k, v|
          raise ArgumentError, "key2 is invalid argument\n#{Error::USAGE}" if v.has_key? nil
          pp [k, v.sort_by {|k, v| v }.reverse]
        end
      else
        raise ArgumentError, "key1 is invalid argument\n#{Error::USAGE}" if analyze.has_key? nil
        analyze.sort_by {|k, v| v }.reverse.each {|a| puts a }
      end
      analyze
    end
  end
end
