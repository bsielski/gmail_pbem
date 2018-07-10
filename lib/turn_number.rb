class TurnNumber
  include Comparable
  def initialize(str)
    @str = str
  end

  def <=>(other)
    str.rjust(10, "0") <=> other.str.rjust(10, "0")
  end

  def to_s
    @str
  end
  
  protected
  def str
    @str
  end
end
