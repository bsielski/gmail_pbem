require "turn_file_name"

RSpec.describe "TurnFileName" do

  context "turn from Empire Deluxe" do
    subject { TurnFileName.new(file_name, id_pattern, turn_pattern, subturn_pattern, subturn_order) }
    let (:file_name) { "Email_World_War_2_P2_T_25__ED_1531079972458_.gz" }
    let (:id_pattern) { '/__ED_(\d*)_/'}
    let (:turn_pattern) { '/_T_(\d*)_/'}
    let (:subturn_pattern) { '/_(P\d*)_T_/'}
    let (:subturn_order) { ["P1", "P2"] }

    it "gives id" do
      expect(subject.id).to eq "1531079972458"
    end
    
    it "gives turn number" do
      expect(subject.turn_number.to_s).to eq "25"
    end
    
    it "gives subturn index" do
      expect(subject.subturn_index).to eq 1
    end

    it "gives subturn name" do
      expect(subject.subturn_name).to eq "P2"
    end

    context "without turn" do
      let (:file_name) { "Email_World_War_2_P2_T___ED_1531079972458_.gz" }
      
      it "doesn't give turn number" do
        expect(subject.turn_number).to be nil
      end
    end

    context "without subturn" do
      let (:file_name) { "Email_World_War_2__T___ED_1531079972458_.gz" }
      
      it "gives infinity subturn index" do
        expect(subject.subturn_index).to be Float::INFINITY
      end
      
      it "doesn't give subturn name" do
        expect(subject.subturn_name).to be nil
      end    
    end

    context "without id" do
      let (:file_name) { "Email_World_War_2__T___ED_.gz" }
      
      it "gives nil id" do
        expect(subject.id).to be nil
      end
    end

    context "comparing to next turn" do
      let (:next_turn) { TurnFileName.new(next_file_name, id_pattern, turn_pattern, subturn_pattern, subturn_order) }
      let (:next_file_name) { "Email_World_War_2_P2_T_26__ED_1531079972458_.gz" }

      it "is older than next turn" do
        expect(subject).to be < next_turn
      end
    end

    context "comparing to previous turn" do
      let (:previous_turn) { TurnFileName.new(previous_file_name, id_pattern, turn_pattern, subturn_pattern, subturn_order) }
      let (:previous_file_name) { "Email_World_War_2_P2_T_24__ED_1531079972458_.gz" }
      
      it "is older than next turn" do
        expect(subject).to be > previous_turn
      end
    end

    context "comparing to previous subturn" do
      let (:previous_turn) { TurnFileName.new(previous_file_name, id_pattern, turn_pattern, subturn_pattern, subturn_order) }
      let (:previous_file_name) { "Email_World_War_2_P1_T_25__ED_1531079972458_.gz" }
      
      it "is older than next turn" do
        expect(subject).to be > previous_turn
      end
    end
  end
end
