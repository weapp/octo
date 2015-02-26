class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def shard_file
    'config/shards.yml'
  end

  def shard_chache_time
    50.seconds
  end

  def load_shard_value
    File.read(File.expand_path(shard_file, Rails.root))
  end

  def get_shard_value
    return @shard if @shard
    unless cached
      update_last_sync
      ENV['shard'] = "#{load_shard_value}"
    end
    @shard = HashWithIndifferentAccess.new(YAML.load(ENV['shard']))[:octopus][:development]
  end

  before_action :reconfigure_shards

  def reconfigure_shards
    sh = get_shard_value
    Octopus.shards = sh
    ActiveRecord::Base.connection.initialize_replication(sh)
    ActiveRecord::Base.connection.instance_eval{@slave_index = Random.rand(0...sh.count)}

    Cephalopod.first
    conn = Thread.current[:'octopus.current_model'].connection
    @lcs = conn.instance_variables.inject({})do |memo, var|
      memo[var] = conn.instance_variable_get(var)
      memo
    end
  end

  def cached
    last_sync && last_sync > shard_chache_time.ago
  end

  def last_sync
    @last_sync ||= ENV['last_sync'].blank? ? nil : Time.at(ENV['last_sync'].to_i)
  end

  def update_last_sync
    ENV['last_sync'] = "#{Time.now.to_i}"
  end

end
