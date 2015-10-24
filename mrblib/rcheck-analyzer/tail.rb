module RcheckAnalyzer
  # ref: http://www.clear-code.com/blog/2010/6/23.html
  class Tail
    def initialize(io)
      @io = io
      @io.seek(0, IO::SEEK_END)
      @buffer = ""
      @data = ""
    end
  
    def each
      separator = "\n"
      separator_length = separator.length
      while read_to_buffer
        loop do
          index = @buffer.rindex(separator, @buffer.length - 1 - separator_length)
          break if index.nil? or index == 0
          last_line = @buffer.slice!((index + separator_length)..-1)
          yield(last_line)
        end
      end
      yield(@buffer) unless @buffer.empty?
    end
  
    private
    BYTES_PER_READ = 4096
    def read
      position = @io.pos
      if position < BYTES_PER_READ
        bytes_per_read = position
      else
        bytes_per_read = BYTES_PER_READ
      end
  
      if bytes_per_read == 0
        @data.replace("")
      else
        @io.seek(-bytes_per_read, IO::SEEK_CUR)
        @io.sysread(bytes_per_read, @data)
        @io.seek(-bytes_per_read, IO::SEEK_CUR)
      end
  
      @data
    end
  
    def read_to_buffer
      data = read
      if data.empty?
        false
      else
        @buffer = data + @buffer
        true
      end
    end
  end
end
