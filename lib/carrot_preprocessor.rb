require_relative './carrot_lexer.rb'

# Processes the symbols into an html file

class Preprocessor
  attr_reader :variables

  def self.create_html_file(crt_string, user)
    @tokens = []
    @variables = {}
    @text = ""
    @user = user
    self.process(crt_string)
    return @text
  end

  private
  def self.process(line)
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
        if token.value == "photos"
          # byebug
          i+=1
          while 1
            token = @tokens[i]
            if token.nil?
              return
            end

            if token.type == :variable
              if token.value == "photo" # We are doing something with a single photo
                # for production, path needs to be "/i/"
                # TODO: No <% end %> in sight
                @user.images.reverse.each do |image|
                  @text << '<p>' + image.title + '</p>'
                  @text << '<div class="image_container">
                          <img src= "/images/' + image.path + '" alt="Image">
                          </div>'
                end
                token = @tokens[i]
              end
            end
            i+=1
          end
          i+=1
        end
        if @tokens[i + 1] != nil && @tokens[i + 1].type == :equals
          i += 1
          if @tokens[i + 1] != nil && @tokens[i + 1].type == :variable
            i += 1
            @variables[token.value] = @tokens[i].value
          end
        end
        if @variables.has_key? @tokens[i].value
          @text << @variables[@tokens[i].value][1...-1]
        else
          puts @tokens[i].value + " " + @variables.to_s
        end
      when :non_syntax
        @text << token.value
      end
    end
    @tokens = []
  end
end
