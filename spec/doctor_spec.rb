require("spec_helper")

describe(Doctor) do
  describe(".all") do
    it "starts of with no doctors" do
      expect(Doctor.all()).to(eq([]))
    end
  end

  describe("#name") do
    it "tells you its name" do
      doctor = Doctor.new({:name => "Clarence", :specialty => "hematology"})
      expect(doctor.name()).to(eq("Clarence"))
    end
  end

  describe("#specialty") do
    it "tells you its specialty" do
      doctor = Doctor.new({:name => "Clarence", :specialty => "hematology"})
      expect(doctor.specialty()).to(eq("hematology"))
    end
  end

  describe("#save") do
    it "saves doctor entry into doctor database" do
      doctor = Doctor.new({:name => "Clarence", :specialty => "hematology"})
      doctor.save()
      expect(Doctor.all()).to(eq([doctor]))
    end
  end

  describe("#==") do
    it("is the same doctor if it has the same name") do
      doctor1 = Doctor.new({:name => "Clarence", :specialty => "hematology"})
      doctor2 = Doctor.new({:name => "Clarence", :specialty => "hematology"})
      expect(doctor1).to(eq(doctor2))
    end
  end

  describe(".find") do
    it "returns a doctor by its ID" do
      test_doctor = Doctor.new({:name => "Clarence", :specialty => "hematology"})
      test_doctor.save()
      test_doctor2 = Doctor.new({:name => "Roger", :specialty => "oncology"})
      test_doctor2.save()
      expect(Doctor.find(test_doctor2.id())).to(eq(test_doctor2))
    end
  end
end
