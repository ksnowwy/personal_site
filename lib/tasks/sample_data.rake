namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    require 'faker'
    Rake::Task['db:reset'].invoke
    admin = User.create!(:name => "Example User",
                         :email => "example@railstutorial.org",
                         :password => "foobar",
                         :password_confirmation => "foobar")
    admin.toggle!(:admin)
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(:name => name,
                   :email => email,
                   :password => password,
                   :password_confirmation => password)
    end
    User.all(:limit => 3).each do |user|
      5.times do
      test = "test"
        user.articles.create!(:content => Faker::Lorem.paragraphs(3), :heading => test)
      end
    end
  end
end