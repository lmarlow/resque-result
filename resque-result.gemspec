require 'lib/resque/plugins/result/version'

Gem::Specification.new do |s|
  s.name              = "resque-result"
  s.version           = Resque::Plugins::Result::Version
  s.date              = Time.now.strftime('%Y-%m-%d')
  s.summary           = "A Resque plugin for retrieving a job's return value."
  s.homepage          = "http://github.com/lmarlow/resque-result"
  s.email             = "lee.marlow@gmail.com"
  s.authors           = [ "Lee Marlow" ]
  s.has_rdoc          = false

  s.files             = %w( README.md Rakefile LICENSE )
  s.files            += Dir.glob("lib/**/*")
  s.files            += Dir.glob("test/**/*")

  s.description       = <<desc
If you want to be able fetch the result from a Resque
job's perform method.  Results will be encoded using JSON.

  For example:

      require 'resque-result'

      class MyJob
        extend Resque::Plugins::Result

        def self.perform(meta_id, big_num)
          factor(big_num)
        end
      end

      meta0 = MyJob.enqueue(3574406403731)
      meta0.enqueued_at # => 'Wed May 19 13:42:41 -0600 2010'
      meta0.meta_id # => '03c9e1a045ad012dd20500264a19273c'

      # later
      meta1 = MyJob.get_meta('03c9e1a045ad012dd20500264a19273c')
      meta1.succeeded? # => true
      meta1.result # => [ 1299709, 2750159 ]
desc

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    s.add_runtime_dependency('resque', [">= 1.9.0"])
    s.add_runtime_dependency('resque-meta', [">= 1.0.0"])
  else
    s.add_dependency('resque', [">= 1.9.0"])
    s.add_dependency('resque-meta', [">= 1.0.0"])
  end
end
