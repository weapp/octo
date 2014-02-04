class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  def load_shard_value
    "#{Random.rand(1000)} - #{last_sync}"
  end

  def get_shard_value
    @shard
  end

  before_action :reconfigure_shards

  def reconfigure_shards
    unless cached
      update_last_sync
      ENV['shard'] = "#{load_shard_value}"
    end
    @shard = ENV['shard']
  end

  def cached
    last_sync && last_sync > 15.seconds.ago
  end

  def last_sync
    @last_sync ||= ENV['last_sync'].blank? ? nil : Time.at(ENV['last_sync'].to_i)
  end

  def update_last_sync
    ENV['last_sync'] = "#{Time.now.to_i}"
  end

end
