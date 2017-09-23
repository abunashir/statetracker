require "rails_helper"

feature "Tracking an Object State" do
  scenario "with valid object information" do
    setup_and_visit_tracking_page

    fill_in "Object Id", with: 1
    select "Order", from: "Object Type"
    fill_in "Timestamp", with: 1484733173
    click_on "Track"

    expect(page).to have_content("Object State at 1484733173")
    expect(page).to have_content("\"status\"=>\"paid\", \"ship_date\"")
  end

  scenario "for non existance object" do
    setup_and_visit_tracking_page

    fill_in "Object Id", with: 1
    select "Order", from: "Object Type"
    fill_in "Timestamp", with: 10.years.ago.to_i
    click_on "Track"

    expect(page).to have_content("Order 1 Didn't Exist at that time")
  end

  scenario "with empty form data" do
    setup_and_visit_tracking_page

    click_on "Track"

    expect(page).to have_content("Timestampcan't be blank")
    expect(page).to have_content("Object Idcan't be blank")
  end

  def setup_and_visit_tracking_page
    import_a_csv_file_as_objects

    visit root_path
    click_on "Track an object"
  end

  def import_a_csv_file_as_objects
    CsvDataImporter.import(create(:csv_upload))
  end
end
