require_relative './carrot_lexer.rb'

# Processes the symbols into an html file

class Preprocessor
  attr_reader :variables

  def initialize()
    @tokens = []
    @variables = {}
  end

  def create_html_file(crt_file)
    @file = File.new('output.html', 'w')

    crt = File.open(crt_file, 'r')
    crt.each_line do |line|
      process(line)
    end
    return @file
  end

  private
  def process(line)
    @token_stream = LexerStream.new(line)

    while @token_stream.stream.front != nil
      tok = @token_stream.next_token
      # puts tok.value
      @tokens << tok
    end

    @tokens.each_index do |i|
      token = @tokens[i]
      case token.type
      when :variable
        if @tokens[i + 1] != nil && @tokens[i + 1].type == :equals
          i += 1
          if @tokens[i + 1] != nil && @tokens[i + 1].type == :variable
            i += 1
            @variables[token.value] = @tokens[i].value
          end
        end
        if @variables.has_key? @tokens[i].value
          @file.write(@variables[@tokens[i].value])
        else
          puts @tokens[i].value + " " + @variables.to_s
        end
      when :non_syntax
        @file.write(token.value)
      end
    end
    @tokens = []
  end
end