#!/usr/bin/env ruby
require 'date'
TODAY = Date.today
FINISH = Date.parse("2018-03-29")
total = (TODAY..FINISH).count - 1
weekdays = (TODAY..FINISH).count { |date| (1..5).include?(date.wday) } - 2

puts <<~OUTPUT
   Countdown 🎉
  --------------
     Total: #{total}
  Weekdays: #{weekdays}
OUTPUT
