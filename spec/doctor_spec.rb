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
end
