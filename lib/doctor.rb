class Doctor
  attr_reader(:name, :specialty_id, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @specialty_id = attributes.fetch(:specialty_id)
    @id = attributes[:id]
  end

  define_singleton_method(:all) do
    returned_doctors = DB.exec("SELECT * FROM doctors;")
    doctors = []
    returned_doctors.each() do |doctor|
      name = doctor.fetch("name")
      specialty_id = doctor.fetch("specialty_id").to_i()
      id = doctor.fetch("id").to_i()
      doctors.push(Doctor.new({:name => name, :specialty_id => specialty_id, :id => id}))
    end
    doctors
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO doctors (name, specialty_id) VALUES ('#{@name}', '#{@specialty_id}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |another_doctor|
    self.name().==(another_doctor.name()).&(self.specialty_id().==(another_doctor.specialty_id())).&(self.id().==(another_doctor.id()))
  end

  define_singleton_method(:find) do |id|
    found_doctor = nil
    Doctor.all().each() do |doctor|
      if doctor.id().==(id)
        found_doctor = doctor
      end
    end
    found_doctor
  end

  define_method(:patients) do
    doctor_patients = []
    patients = DB.exec("SELECT * FROM patients WHERE doctor_id = #{self.id()};")
    patients.each() do |patient|
      name = patient.fetch("name")
      doctor_id = patient.fetch("doctor_id").to_i()
      birthdate = patient.fetch("birthdate")
      doctor_patients.push(Patient.new({:name => name, :doctor_id => doctor_id, :birthdate => birthdate}))
    end
    doctor_patients
  end
end
