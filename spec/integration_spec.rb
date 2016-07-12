require('capybara/rspec')
require('./app')
require('spec_helper')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe("adding a new doctor", {:type => :feature}) do
  it "allows an administrator to add a doctor to the office" do
    visit('/')
    click_link("Add New Doctor")
    fill_in("name", :with => "Clarence")
    fill_in("specialty", :with => "hematology")
    click_button("Add Doctor")
    expect(page).to have_content("Success")
    click_link("Home")
    click_link("View All Doctors")
    expect(page).to have_content("Clarence")
  end
end
