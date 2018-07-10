require_relative "./pbem"
require_relative "./incoming_folders"
require_relative "./outgoing_folder"
require 'gmail'

class Loop
  def initialize(delay: 10, config:)
    @delay = delay
    @config = config
  end

  def run
    pbems = create_pbems
    while true do
      pbems.each do |pbem|
        pbem.download_turn
      end
      sleep @delay
    end
    
  end
  
  private

  def create_pbems
    pbems = []
    @config.options.each do |name|
      puts name
      email_login = @config[name]["mail_account"]["login"]
      email_password = @config[name]["mail_account"]["password"]
      gmail = Gmail.new(email_login, email_password)
      incoming_folders = IncomingFolders.new(
        @config[name]["incoming_folders"],
        @config[name]["id_value"].to_s,
        @config[name]["id_find_pattern"],
        @config[name]["turn_find_pattern"],
        @config[name]["subturn_pattern"],
        @config[name]["subturn_order"],
        @config[name]["keep_downloaded_minimum_last"]
      )
      outgoing_folder = OutgoingFolder.new(
        @config[name]["outgoing_folder"]
      )
      pbem_config = {
        gmail: gmail,
        name: name,
        email_label: @config[name]["email_label"],
        incoming_folders: incoming_folders,
        outgoing_folder: outgoing_folder,
        id_value: @config[name]["id_value"].to_s,
        id_find_pattern: @config[name]["id_find_pattern"],
        turn_find_pattern: @config[name]["turn_find_pattern"],
        subturn_pattern: @config[name]["subturn_pattern"],
        subturn_order: @config[name]["subturn_order"]
      }
      puts email_login
      pbem = PBEM.new(**pbem_config)
      pbems << pbem
    end
    puts
    pbems
  end
end
