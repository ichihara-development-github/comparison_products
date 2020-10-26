timeout 10
preload_app true

worker_processes 3

@sidekiq_pid = nil

before_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

  if Rails.env.production?
    spawn("mkdir -p tmp/pids")
    @sidekiq_pid ||= spawn("bundle exec sidekiq -C config/sidekiq.yml")
    Rails.logger.info('Spawned sidekiq #{@sidekiq_pid}')
  end
end
