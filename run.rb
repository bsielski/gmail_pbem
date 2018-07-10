require_relative "./lib/loop"
require_relative "./lib/config"
require 'yaml'

config = Config.new(
  YAML.load_file("pbems.yml"),
  {"mail_account" => YAML.load_file("mail_accounts.yml")}
)

Loop.new(config: config, delay: 15).run
