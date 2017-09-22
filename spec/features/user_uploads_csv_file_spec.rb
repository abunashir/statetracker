require "rails_helper"

feature "User uploads a CSV file" do
  scenario "creates a new upload with valid data" do
    visit root_path
    click_on "Upload A CSV"

    attach_file("CSV File", sample_csv_fixture_file)
    click_on "Upload"

    expect(page).to have_content("Imported")
    expect(page).to have_content("sample.csv")
    expect(page).to have_content(I18n.t("csv_upload.create.success"))
  end

  scenario "does not create a upload with invalid data" do
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
