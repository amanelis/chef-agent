# Class patching
# Enumerable#in_parallel: allows you to parallelize work on collections. Remember, they
# act like normal threads and do not recieve a copy of global variables.
module Enumerable
  def in_parallel
    map { |x| Thread.new { yield(x) } }.each{ |t| t.join }
  end
end