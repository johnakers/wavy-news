set :output, './log/cron.log'

# clear crontab -> crontab -r
# write crontab -> bundle exec whenever --update-crontab

every 1.minutes do
  # runner "puts 'hello, world'"
  # rake "rake stories:repopulate_top10_stories"
end
