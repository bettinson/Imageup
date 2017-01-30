# require 'byebug'
require 'test/unit'
require 'test/unit/ui/console/testrunner'

require './carrot_lexer.rb'
# require './preprocessor.rb'

class LexerTest < Test::Unit::TestCase
  def setup
    @str = "{{hello}}"
    @stream = StringStream.new(@str)
    @lexer = LexerStream.new(@str)
  end

  def test_string_stream
    assert_equal @str, @stream.string
  end

  def test_string_stream_pop_and_front
    assert_equal @str, @stream.string
    @stream.pop_front
    assert_equal "{hello}}", @stream.string
    assert_equal '{', @stream.front
  end

  def test_front_of_lexer
    assert_equal @lexer.next_token.value, '{{'
  end

  def test_string_before_syntax
    str = "hello {{ }}"
    @lexer = LexerStream.new(str)
    assert_equal @lexer.next_token.value, 'hello '
    assert_equal @lexer.next_token.value, '{{'
  end

  def test_variable_assignment_tokens_on_left_side
    str = "this can be absolutely anything. {{ hey = 'foo'; }}"
    @lexer = LexerStream.new(str)
    assert_equal @lexer.next_token.value, 'this can be absolutely anything. '
    assert_equal @lexer.next_token.value, '{{'
    assert @lexer.stream.in_syntax?
    assert_equal @lexer.next_token.value, 'hey'
    assert_equal @lexer.next_token.value, '='
    assert_equal @lexer.next_token.value, "'foo'"
    assert_equal @lexer.next_token.value, ';'
    assert_equal @lexer.next_token.value, '}}'
    # assert !@lexer.stream.in_syntax?
  end

  def test_right_side_is_not_syntax
    str = "{{hey = 'foo hey';}} this is not syntax"
    @lexer = LexerStream.new(str)
    assert_equal @lexer.next_token.value, '{{'
    assert @lexer.stream.in_syntax?
    assert_equal @lexer.next_token.value, 'hey'
    assert_equal @lexer.next_token.value, '='
    assert_equal @lexer.next_token.value, "'foo hey'"
    assert_equal @lexer.next_token.value, ';'
    assert_equal @lexer.next_token.value, '}}'
    assert_equal @lexer.next_token.value, ' this is not syntax'
    assert !@lexer.stream.in_syntax
  end

#  def test_simple_token_array
#    toks = Lexer.lex('{{title="Matt\'s blog"}}')
#    test_array = ["{{", "title", "=", '"', "Matt's"," ","blog", '"', "}}"]
#    index = 0
#    toks.select{|c| c.class == Token }.each do |s|
#      assert_equal test_array[index], s.value
#      index = index + 1
#    end
#  end
#
#  def test_errors_on_reserved_word_assignment
#    assert_raise ArgumentError do
#      Lexer.lex('{{photos="Matt\'s blog"}}')
#    end
#  end
#
#  def test_no_errors_on_keyword_usage
#    assert_nothing_raised do
#      Lexer.lex('{{ photos }}')
#    end
#  end
end

# class PreProcessorTest < Test::Unit::TestCase
#  def setup
#  end

#  def test_basic_var_assignment
#    test_hash = Hash.new
#    processer = Preprocessor.new()
#    test_hash["var"] = "Matt"
#    assert_equal processer.process_string('{{var="Matt"}}'), test_hash
  
#  end
# end
