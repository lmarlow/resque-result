require File.dirname(__FILE__) + '/test_helper'
require 'resque/plugins/result'

class ResultJob
  extend Resque::Plugins::Result
  @queue = :test

  def self.perform(meta_id, big_num)
    [ 1299709, 2750159 ]
  end
end

class ResultTest < Test::Unit::TestCase
  def setup
    Resque.redis.flushall
  end

  def test_result_version
    assert_equal '1.0.0', Resque::Plugins::Result::Version
  end

  def test_lint
    assert_nothing_raised do
      Resque::Plugin.lint(Resque::Plugins::Result)
    end
  end

  def test_resque_version
    major, minor, patch = Resque::Version.split('.')
    assert_equal 1, major.to_i
    assert minor.to_i >= 9
  end

  def test_processed_job
    meta = ResultJob.enqueue(3574406403731)
    assert_nil meta.result
    worker = Resque::Worker.new(:test)
    worker.work(0)

    meta = ResultJob.get_meta(meta.meta_id)
    assert meta.succeeded?, 'Job should have succeeded'
    assert_equal [ 1299709, 2750159 ], meta.result
  end
end
