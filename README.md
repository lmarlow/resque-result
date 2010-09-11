Resque Result
=============

A [Resque][rq] plugin. Requires Resque 1.8.

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

[rq]: http://github.com/defunkt/resque
