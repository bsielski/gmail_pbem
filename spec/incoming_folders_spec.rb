require "incoming_folders"

dir = Dir.new("C:/Users/John/AppData/LocalLow/KBSW/EmpireDeluxe/emailinboundold")
p dir
p dir.inspect
p dir.each.to_a

class FakeDir
  include Enumerable
  def initialize(fake_dir_path, fake_entries)
    @fake_dir_path = fake_dir_path
    @fake_entries = fake_entries
  end

  def each
    @fake_entries.each
  end

  def close
    nil
  end
end

RSpec.describe "IncomingFolders" do
  subject { IncomingFolders.new(folders, id_value, id_find_pattern, turn_find_pattern, subturn_pattern, subturn_order, keep_downloaded_minimum_last) }
  let (:folders) { [first_folder, second_folder] }
  let (:first_folder) { FakeDir.new(
                          "C:/Users/Johhny/EmpireDeluxe/emailinbound",
                          [ ]
                        )
  }
  let (:second_folder) { FakeDir.new(
                           "C:/Users/Johhny/EmpireDeluxe/emailinboundold",
                           [
                             ".",
                             "..",
                             "Email_Nubian_Conquest__Final_Game.gz",
                             "Email_Nubian_Conquest__P2_T_200__ED_1529518583068_.gz",
                             "Email_Nubian_Conquest__P2_T_201__ED_1529518583068_.gz",
                             "Email_Nubian_Conquest__P2_T_202__ED_1529518583068_.gz",
                             "Email_Nubian_Conquest__P2_T_203__ED_1529518583068_.gz",
                             "Email_Nubian_Conquest__P2_T_204__ED_1529518583068_.gz",
                             "Email_Nubian_Conquest__P2_T_205__ED_1529518583068_.gz",
                             "Email_Nubian_Conquest__P2_T_206__ED_1529518583068_.gz",
                             "Email_Nubian_Conquest__P2_T_207__ED_1529518583068_.gz",
                             "Email_Nubian_Conquest__P2_T_208__ED_1529518583068_.gz",
                             "Email_Nubian_Conquest__P2_T_209__ED_1529518583068_.gz",
                             "Email_Nubian_Conquest__P2_T_210__ED_1529518583068_.gz",
                             "Email_Nubian_Conquest__P2_T_211__ED_1529518583068_.gz",
                             "Email_Nubian_Conquest__P2_T_212__ED_1529518583068_.gz",
                             "Email_Nubian_Conquest__P2_T_213__ED_1529518583068_.gz",
                             "Email_Nubian_Conquest__P2_T_214__ED_1529518583068_.gz",
                             "Email_Nubian_Conquest__P2_T_215__ED_1529518583068_.gz",
                             "Email_Nubian_Conquest__P2_T_216__ED_1529518583068_.gz",
                             "Email_Nubian_Conquest__P2_T_217__ED_1529518583068_.gz",
                             "Email_Nubian_Conquest__P2_T_26__ED_1529518583068_.gz",
                             "Email_Nubian_Conquest__P2_T_30__ED_1529518583068_.gz",
                             "Email_Nubian_Conquest__P2_T_34__ED_1529518583068_.gz",
                             "Email_Nubian_Conquest__P2_T_38__ED_1529518583068_.gz",
                             "Email_Nubian_Conquest__P2_T_42__ED_1529518583068_.gz",
                             "Email_Nubian_Conquest__P2_T_46__ED_1529518583068_.gz",
                             "Email_Nubian_Conquest__P2_T_52__ED_1529518583068_.gz",
                             "Email_Nubian_Conquest__P2_T_56__ED_1529518583068_.gz",
                             "Email_Nubian_Conquest__P2_T_64__ED_1529518583068_.gz",
                             "Email_Nubian_Conquest__P2_T_67__ED_1529518583068_.gz",
                             "Email_Nubian_Conquest__P2_T_72__ED_1529518583068_.gz",
                             "Email_Nubian_Conquest__P2_T_74__ED_1529518583068_.gz",
                             "Email_Nubian_Conquest__P2_T_76__ED_1529518583068_.gz",
                             "Email_Nubian_Conquest__P2_T_77__ED_1529518583068_.gz",
                             "Email_Nubian_Conquest__P2_T_78__ED_1529518583068_.gz",
                             "Email_Nubian_Conquest__P2_T_84__ED_1529518583068_.gz",
                             "Email_Nubian_Conquest__P2_T_86__ED_1529518583068_.gz",
                             "Email_Nubian_Conquest__P2_T_90__ED_1529518583068_.gz",
                             "Email_Nubian_Conquest__P2_T_91__ED_1529518583068_.gz",
                             "Email_Nubian_Conquest__P2_T_94__ED_1529518583068_.gz",
                             "Email_Nubian_Conquest__P2_T_96__ED_1529518583068_.gz",
                             "Email_Nubian_Conquest__P2_T_97__ED_1529518583068_.gz",
                             "Email_Nubian_Conquest__ToAssignPlayer_2__ED_1529518583068_.gz",
                             "Email_World_War_2_P2_T_1__ED_1531079972458_.gz",
                             "Email_World_War_2_P2_T_25__ED_1531079972458_.gz",
                             "Email_World_War_2_P2_T_46__ED_1531079972458_.gz",
                             "Email_World_War_2_P2_T_51__ED_1531079972458_.gz",
                             "Email_World_War_2_P2_T_57__ED_1531079972458_.gz",
                             "Email_World_War_2_P2_T_66__ED_1531079972458_.gz",
                             "Email_World_War_2_P2_T_74__ED_1531079972458_.gz",
                             "Email_World_War_2_P2_T_75__ED_1531079972458_.gz",
                             "Email_World_War_2_P2_T_79__ED_1531079972458_.gz",
                             "Email_World_War_2_ToAssignPlayer_2__ED_99991531079972458_.gz"

                           ]
                         )
  }
  let (:id_value) { "Email_Nubian_Conquest" }
  let (:id_pattern) { '/^Email_(.*).gz$/'}
  let (:turn_pattern) { '/_T_(\d*)_/'}
  let (:subturn_pattern) { '/_P?(\d*)_T?_/'}
  let (:subturn_order) { ["1", "2"] }
  let (:keep_downloaded_minimum_last) { 3 }

end
