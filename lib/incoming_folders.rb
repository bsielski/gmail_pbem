require_relative "./turn_file_name"

class IncomingFolders
  def initialize(folders, id_value, id_find_pattern, turn_find_pattern, subturn_pattern, subturn_order, keep_downloaded_minimum_last)
    @folders = folders
    @id_value = id_value
    @id_find_pattern = id_find_pattern
    @turn_find_pattern = turn_find_pattern
    @subturn_pattern = subturn_pattern
    @subturn_order = subturn_order
    @keep_downloaded_minimum_last = keep_downloaded_minimum_last
  end

  def save(file, file_name)
    puts "Saving #{file_name}..."
    File.open(primary_folder + file_name, "wb") do |f|
      f << file
      puts "Saved"
    end
    sleep 10
  end

  def max_turns_to_download
    number_of_missing = @keep_downloaded_minimum_last - downloaded_turns.size
    return 1 if number_of_missing < 1
    number_of_missing
  end

  def last_turn_downloaded
    turn_file_names = downloaded_turns
    turn_file_names.max
  end

  def turn_downloaded?(id, id_find_pattern, turn, turn_find_pattern, subturn_pattern, subturn_order)
    turn_file_names = downloaded_turns
    turn_file_names.any? do |name|
      name.turn_number == turn
    end
  end

  def downloaded_turns
    turn_file_names = []
    @folders.each do |folder|
      all_file_names = Dir.glob("#{folder}*").map do |path|
        TurnFileName.new(File.basename(path), @id_find_pattern, @turn_find_pattern, @subturn_pattern, @subturn_order)
      end
      turn_file_names.concat(all_file_names)
    end
    turn_file_names.select do |name|
      name.id == @id_value
    end
  end
  
  def primary_folder
    @folders.first
  end
end
