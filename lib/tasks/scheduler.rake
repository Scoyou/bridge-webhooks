task :sync_users => :environment do
    UserWorker.perform_async()
  end