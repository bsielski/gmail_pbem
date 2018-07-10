class Notification
  def initialize(folder_name, file_name, notepad_command)
    @folder_name = folder_name
    @file_name = file_name
    @notepad_command = notepad_command
  end

  def show(pbem_name, turn_file_name, date)
    text = "#{pbem_name}:\nturn: #{turn_file_name.turn_number}\ndate: #{date.to_s}\ndownloaded at: #{Time.new.to_s}"
    file_path = File.join(@folder_name, @file_name)
    File.open(file_path, "w") do |file|
      file.write("#{text}\n")
    end
    spawn("#{@notepad_command} #{file_path}")
  end
end
