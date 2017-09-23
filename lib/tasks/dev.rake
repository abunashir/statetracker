if Rails.env.development? || Rails.env.test?
  require "factory_girl"

  namespace :dev do
    desc "Sample data for local development environment"
    task prime: "db:setup" do
      include FactoryGirl::Syntax::Methods

      # create(:user, email: "user@example.com", password: "password")
    end

    desc "Create database, run migration and seed sample data"
    task complete_build: ["db:create", "db:migrate", "db:seed"]
  end
end
