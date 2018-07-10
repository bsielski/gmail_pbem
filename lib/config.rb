class Config
  def initialize(hash, imports={})
    @hash = hash
    @imports = imports
  end

  def [](option)
    if @imports.keys.include? option
      self.class.new(@imports[option][@hash[option]], @imports)
    elsif @hash[option].is_a?(Hash)
      self.class.new(@hash[option], @imports)
    else
      @hash[option]
    end
  end

  def options
    @hash.keys
  end

end
