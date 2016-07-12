require("spec_helper")

describe(Specialty) do
  describe(".all") do
    it "starts of with no specialties" do
      expect(Specialty.all()).to(eq([]))
    end
  end

  describe("#area") do
    it "tells you its area" do
      specialty = Specialty.new({:area => "neurology", :id => nil})
      expect(specialty.area()).to(eq("neurology"))
    end
  end

  describe("#id") do
    it "tells you its id" do
      specialty = Specialty.new({:area => "neurology", :id => nil})
      expect(specialty.id()).to(eq(nil))
    end
  end

  describe("#save") do
    it "saves specialty entry into specialty database" do
      specialty = Specialty.new({:area => "neurology", :id => nil})
      specialty.save()
      expect(Specialty.all()).to(eq([specialty]))
    end
  end

  describe("#==") do
    it("is the same specialty if it has the same area") do
      specialty1 = Specialty.new({:area => "neurology", :id => nil})
      specialty2 = Specialty.new({:area => "neurology", :id => nil})
      expect(specialty1).to(eq(specialty2))
    end
  end

  describe(".find") do
    it "returns a specialty by its ID" do
      test_specialty = Specialty.new({:area => "neurology", :id => nil})
      test_specialty.save()
      test_specialty2 = Specialty.new({:area => "pediatrics", :id => nil})
      test_specialty2.save()
      expect(Specialty.find(test_specialty2.id())).to(eq(test_specialty2))
    end
  end

  describe('#doctors') do
    it "returns an array of doctors for that specialty" do
      test_specialty = Specialty.new({:area => "neurology"})
      test_specialty.save()
      test_doctor = Doctor.new({:name => "Lucinda", :specialty_id => test_specialty.id()})
      test_doctor.save()
      test_doctor2 = Doctor.new({:name => "Esmerelda", :specialty_id => test_specialty.id()})
      test_doctor2.save()
      expect(test_specialty.doctors()).to(eq([test_doctor, test_doctor2]))
    end
  end
end
