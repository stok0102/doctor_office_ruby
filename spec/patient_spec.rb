require("spec_helper")

describe(Patient) do
  describe("#name") do
    it("lets you give it a name") do
      test_patient = Patient.new({:name => "Lucinda", :doctor_id => 1, :birthdate => '1973-03-24'})
      expect(test_patient.name()).to(eq("Lucinda"))
    end
  end

  describe("#birthdate") do
    it("lets you give it a birth date") do
      test_patient = Patient.new({:name => "Lucinda", :doctor_id => 1, :birthdate => '1973-03-24'})
      expect(test_patient.birthdate()).to(eq('1973-03-24'))
    end
  end

  describe(".all") do
    it("is empty at first") do
      expect(Patient.all()).to(eq([]))
    end
  end

  describe("#save") do
    it("adds a patient to the array of saved patients") do
      test_patient = Patient.new({:name => "Lucinda", :doctor_id => 1, :birthdate => '1973-03-24'})
      test_patient.save()
      expect(Patient.all()).to(eq([test_patient]))
    end
  end

  describe("#doctor_id") do
    it "lets you read the doctor ID out" do
      test_patient = Patient.new({:name => "Lucinda", :doctor_id => 1, :birthdate => '1973-03-24'})
      expect(test_patient.doctor_id()).to(eq(1))
    end
  end

  describe("#==") do
    it("is the same patient if it has the same name") do
      patient1 = Patient.new({:name => "Lucinda", :doctor_id => 1, :birthdate => '1973-03-24'})
      patient2 = Patient.new({:name => "Lucinda", :doctor_id => 1, :birthdate => '1973-03-24'})
      expect(patient1).to(eq(patient2))
    end
  end

  describe("#delete") do
    it("deletes a patient") do
      patient1 = Patient.new({:name => "Lucinda", :doctor_id => 1, :birthdate => '1973-03-24'})
      patient1.save()
      expect(Patient.all()).to(eq([patient1]))
      patient1.delete()
      expect(Patient.all()).to(eq([]))
    end
  end
end
