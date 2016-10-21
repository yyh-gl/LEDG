clear_time = 0
ok_flag = FALSE

loop do
  File.open("time.txt", 'r') do |f|
    f.each_line do |line|
      if line.to_i == 1 then
        ok_flag = TRUE
        break
      end
    end
  end
  break if ok_flag == TRUE
end

puts 'start'

loop do
  sleep(1)
  clear_time += 1

  File.open("time.txt", 'w') do |f|
    f.puts(clear_time)
  end
end
