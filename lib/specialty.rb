class Specialty
  attr_reader(:area, :id)

  define_method(:initialize) do |attributes|
    @area = attributes.fetch(:area)
    @id = attributes[:id]
  end

  define_singleton_method(:all) do
    returned_specialties = DB.exec("SELECT * FROM specialties;")
    specialties = []
    returned_specialties.each() do |specialty|
      area = specialty.fetch("area")
      id = specialty.fetch("id").to_i()
      specialties.push(Specialty.new({:area => area, :id => id}))
    end
    specialties
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO specialties (area, specialty_id) VALUES ('#{@area}', '#{@specialty_id}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |another_specialty|
    self.area().==(another_specialty.area()).&(self.id().==(another_specialty.id()))
  end

  define_singleton_method(:find) do |id|
    found_specialty = nil
    Specialty.all().each() do |specialty|
      if specialty.id().==(id)
        found_specialty = specialty
      end
    end
    found_specialty
  end

  define_method(:doctors) do
    specialty_doctors = []
    doctors = DB.exec("SELECT * FROM doctors WHERE specialty_id = #{self.id()};")
    doctors.each() do |doctor|
      name = doctor.fetch("name")
      specialty_id = doctor.fetch("specialty_id").to_i()
      id = doctor.fetch("id")
      specialty_doctors.push(Doctor.new({:name => name, :specialty_id => specialty_id, :id => nil}))
    end
    specialty_doctors
  end
end
