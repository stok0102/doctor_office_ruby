require('pry')

class Patient
  attr_reader(:name, :doctor_id, :birthdate)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @doctor_id = attributes.fetch(:doctor_id)
    @birthdate = attributes.fetch(:birthdate)
    @id = attributes[:id]
  end

  define_singleton_method(:all) do
    returned_patients = DB.exec("SELECT * FROM patients ORDER BY birthdate;")
    patients = []
    returned_patients.each() do |patient|
      name = patient.fetch("name")
      doctor_id = patient.fetch("doctor_id").to_i()
      birthdate = patient.fetch("birthdate")
      id = patient.fetch("id").to_i()
      patients.push(Patient.new({:name => name, :doctor_id => doctor_id, :birthdate => birthdate, :id => id}))
    end
    patients
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO patients (name, doctor_id, birthdate) VALUES ('#{@name}', #{@doctor_id}, '#{@birthdate}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |another_patient|
    self.name().==(another_patient.name()).&(self.doctor_id().==(another_patient.doctor_id())).&(self.birthdate().==(another_patient.birthdate()))
  end

  define_method(:delete) do
    DB.exec("DELETE FROM patients WHERE id = #{@id}")
  end
end
