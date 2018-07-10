require_relative "./turn_number"

class TurnFileName
  include Comparable
  def initialize(file_name, id_pattern, turn_pattern, subturn_pattern, subturn_order)
    @file_name = file_name
    @turn_pattern = turn_pattern
    @id_pattern = id_pattern
    @subturn_pattern = subturn_pattern
    @subturn_order = subturn_order
  end
  
  def turn_number
    captured = @file_name.scan(regex_from_string(@turn_pattern)).flatten.last
    return nil if (captured == "" || captured.nil?)
    return TurnNumber.new(captured)
  end
  
  def id
    captured = @file_name.scan(regex_from_string(@id_pattern))
    return nil if captured.flatten.last == ""
    return captured.flatten.last
  end
  
  def <=>(other)
    by_turn_number = turn_number <=> other.turn_number
    return by_turn_number unless by_turn_number == 0
    subturn_index <=> other.subturn_index
  end

  def subturn_index
    @subturn_order.index(subturn_name) || Float::INFINITY
  end

  def subturn_name
    captured = @file_name.scan(regex_from_string(@subturn_pattern)).flatten.last
    return nil if (captured == "" || captured.nil?)
    return captured
  end
  
  private
  
  def regex_from_string(str)
    match = str.match(/\/(.*)\/(i?)$/)
    Regexp.new(match[1], match[2] == "i")
  end
end
