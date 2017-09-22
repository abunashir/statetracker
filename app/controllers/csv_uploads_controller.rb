class CsvUploadsController < ApplicationController
  def index
    @csv_uploads = CsvUpload.recent
  end

  def new
    @csv_upload = CsvUpload.new
  end

  def create
    create_csv_upload || render(:new)
  end

  private

  def create_csv_upload
    @csv_upload = CsvUpload.new(csv_upload_params)

    if @csv_upload.save
      CsvDataImporter.import(@csv_upload)
      redirect_to(root_path, notice: t("csv_upload.create.success"))
    end
  end

  def csv_upload_params
    params.require(:csv_upload).permit(:csv_file, :tag)
  end
end
