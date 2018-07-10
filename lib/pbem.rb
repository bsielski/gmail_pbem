require_relative "./turn_file_name"
require_relative "./notification"

class PBEM
  def initialize(gmail:, name:, email_label:, incoming_folders:, outgoing_folder:, id_value:, id_find_pattern:, turn_find_pattern:, subturn_pattern:, subturn_order:)
    @gmail = gmail
    @name = name
    @email_label = email_label
    @incoming_folders = incoming_folders
    @outgoing_folder = outgoing_folder
    @id_value = id_value
    @id_find_pattern = id_find_pattern
    @turn_find_pattern = turn_find_pattern
    @subturn_pattern = subturn_pattern
    @subturn_order = subturn_order
    @notification = Notification.new("./", "turn-alert.txt", "notepad.exe")
  end

  def download_turn
    result = find_new_turn
    if result
      @incoming_folders.save(result[:attachment].decoded, result[:attachment].filename)
      @notification.show(@name, result[:turn_file_name], result[:email_date])
    end
  end
  
  private

  def find_new_turn
    attachments = []
    emails.reverse_each do |email|
      attachment = email.attachments.first

      # test attachement
      # if is good add to array
      # check if array has enought elements
      # if has than return attachements

      
      turn_file_name = TurnFileName.new(attachment.filename, @id_find_pattern, @turn_find_pattern, @subturn_pattern, @subturn_order)
      downloaded = downloaded?(turn_file_name)
      old = old_turn?(turn_file_name)
      download = !downloaded && !old
      puts "#{attachment.filename} - turn: #{turn_file_name.turn_number} - downloaded?: #{downloaded}, old?: #{old}, download?: #{download}"
      return {
        attachment: attachment,
        turn_file_name: turn_file_name,
        email_date: email.date
      } if download
      break if old
    end
    puts "No new turn"
    nil
  end

  def should_be_download?

  end
  
  def downloaded?(turn_file_name)
    turn_downloaded?(turn_file_name.turn_number)
  end
  
  def old_turn?(turn_file_name)
    turn_file_name < last_turn_downloaded
  end

  def emails
    emails = @gmail.mailbox(@email_label).emails
  end
  
  def last_turn_done
    @outgoing_folder.last_turn_done(@id_value, @id_find_pattern, @turn_find_pattern, @subturn_pattern, @subturn_order)
  end

  def last_turn_downloaded
    @incoming_folders.last_turn_downloaded
  end

  def turn_downloaded?(turn)
    @incoming_folders.turn_downloaded?(@id_value, @id_find_pattern, turn, @turn_find_pattern, @subturn_pattern, @subturn_order)
  end
  
end
