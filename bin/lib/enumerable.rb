# Class patching
# Enumerable#in_parallel: allows you to parallelize work on collections.
module Enumerable
  def in_parallel
    map { |x| Thread.new { yield(x) } }.each{ |t| t.join }
  end
end