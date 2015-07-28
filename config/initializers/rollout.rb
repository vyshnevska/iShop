$redis = Redis.new
module RedisConfig
  module ClassMethods
    def redis_running?
      begin
        $redis.ping
      rescue Redis::CannotConnectError
        Logger.new(STDOUT).info("Redis::CannotConnectError".red)
        return
      end
    end
  end

  def self.included(base)
    base.extend(ClassMethods)
  end
end

class Setup
  include RedisConfig
  extend RedisConfig::ClassMethods

  if redis_running?
    $rollout = Rollout.new($redis)
    $rollout.define_group(:admin) do |user|
      user.admin?
    end
    RolloutUi.wrap($rollout)
  end
end
