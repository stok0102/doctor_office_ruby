require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/patient")
require("./lib/doctor")
require('pg')

DB = PG.connect({:dbname => 'doctor_office'})

get("/") do
  erb(:index)
end

get('/doctors/new') do
  erb(:doctors_form)
end

post('/doctors') do
  name = params.fetch('name')
  specialty = params.fetch('specialty')
  doctor = Doctor.new({:name => name, :specialty => specialty, :id => nil})
  doctor.save()
  erb(:success)
end

get('/doctors') do
  @doctors = Doctor.all()
  erb(:doctors)
end

get('/doctors/:id') do
  @doctor = Doctor.find(params.fetch("id").to_i())
  erb(:doctor)
end

post("/patients") do
  name = params.fetch("name")
  birthdate = params.fetch("birthdate")
  doctor_id = params.fetch("doctor_id").to_i()
  @doctor = Doctor.find(doctor_id)
  @patient = Patient.new({:name => name, :doctor_id => doctor_id, :birthdate => birthdate})
  @patient.save()
  erb(:success)
end
