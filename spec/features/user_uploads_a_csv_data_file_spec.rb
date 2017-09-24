require "rails_helper"

feature "Uploading a CSV" do
  scenario "with valid info imports the data properly" do
    visit root_path
    click_on "Upload A CSV"

    attach_file("CSV File", sample_csv_fixture_file)
    click_on "Upload"

    expect(page).to have_content("Imported")
    expect(page).to have_content("sample.csv")
    expect(page).to have_content(I18n.t("csv_uploads.create.success"))
  end

  scenario "with invalid data does not import anything" do
    visit root_path
    click_on "Upload A CSV"

    click_on "Upload"

    expect(current_path).to eq(csv_uploads_path)
    expect(page).to have_content("CSV Filecan't be blank")
  end

  def sample_csv_fixture_file
    @sample_csv ||= File.join(Rails.root, "spec/fixtures/sample.csv")
  end
end
