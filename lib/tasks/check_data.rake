namespace :check_data do

  desc "Check users from mongo"
  task countUsers: :environment do
  	puts 'Checking users from mongo, please wait ...'
  	@users = User.all.count
  	puts "#{@users} users found"
  end

  desc "Add admin user"
  task addAdminUser: :environment do
  	puts 'Creating an admin default user'
  	@user = User.new(:name => 'Administrator', :email => 'admin@gmail.com', :password => '12345678', :password_confirmation => '12345678', :user_type => 'superUser')
  	if @user.save(validate: false)
  		puts 'User created successfully'
  	else
  		puts 'There was an error creating the user'
  	end
  end
  
  desc "Add Torcida Manager"
  task addTorcidaManager: :environment do
  	@user = User.new(:name => 'Torcida Manager', :email => 'torcida@chupin.com.br', :password => '12345678', :password_confirmation => '12345678', :user_type => 'torcidaUser', :cpf => '125.456.234-23', :torcida_id => Torcida.all.first.id.to_s)
  	@user.save(validate: false)
  	puts 'OKAY'
  end

  desc "Add Clube Manager"
  task addClubeManager: :environment do
  	@user = User.new(:name => 'Time Manager', :email => 'time@chupin.com.br', :password => '12345678', :password_confirmation => '12345678', :user_type => 'clubeUser', :cpf => '125.456.234-23', :torcida_id => Torcida.all.first.id.to_s )
  	@user.save(validate: false)
  	puts 'OKAY'
  end

  desc "Add app test users"
  task addAppUsers: :environment do
  	@user = User.new(:name => 'Chupin', :email => 'chupin@chupin.com.br', :password => '12345678', :password_confirmation => '12345678', :user_type => 'User', :cpf => '123.456.234-23' :status => 6 )
  	@user.save(validate: false)
  	puts 'OKAY'
  end

  desc "Delete users"
  task addTorcidaUser: :environment do
  	@user = User.where(:email => 'chupin@chupin.com.br').first
  	@user.torcida_id = Torcida.all.first.id.to_s
  	@user.save(validate: false)
  	puts 'OKAY'
  end
  
end
