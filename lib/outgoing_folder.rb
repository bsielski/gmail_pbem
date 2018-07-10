require_relative "./turn_file_name"

class OutgoingFolder
  def initialize(folder)
    @folder = folder
  end

  def last_turn_done(id_value, id_find_pattern, turn_find_pattern, subturn_pattern, subturn_order)
    turn_file_names = Dir.glob("#{@folder}*").map do |name|
      TurnFileName.new(name.delete_prefix(@folder), id_find_pattern, turn_find_pattern, subturn_pattern, subturn_order)
    end
    turn_file_names = turn_file_names.select do |name|
      name.id == id_value
    end
    turns = turn_file_names.map {|name| name.turn_number}
    turns.max
  end
end
