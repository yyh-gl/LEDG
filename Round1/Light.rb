require './LedSocket'

THRESHOLD = 30
STAGE  = 10
NORMAL = [150, 150, 150, 100]
ZERO   = [0, 0, 0, 0]
RED    = [100, 0, 0, 0]
BLUE   = [0, 100, 0, 0]
GREEN  = [0, 0, 100, 0]
YELLOW = [0, 0, 0, 500]
PINK   = [100, 0, 0, 0]
SBLUE1  = [0, 0, 100, 0]
SBLUE2  = [0, 0, 200, 0]
SBLUE3  = [0, 0, 300, 0]
ORANGE = [100, 0, 0, 100]
LGREEN = [0, 150, 0, 100]

count = 0                 # When 10 touch, clear
r_num = [0, 0, 0]         # randam number

start_flag = FALSE
ok_flag = FALSE

# Light Ready
s = LedSocket.open('172.20.11.68', 14649)
s.update

s.sendAll(ZERO)
s.update
0.upto(28) do |num|
  if num <= 5 || num == 9 || num == 10 || num == 14 || num == 15 || num == 18 || num == 19 || num == 23 || num >= 24 then
    s.sendSingle(num, SBLUE2)
    s.update
  elsif num == 16 then
    s.sendSingle(num, YELLOW)
    s.update
  end
end

# Start Torigger
# Slash on senser under LED no.16, Game start
File.open("log_16.txt", 'w') do |f|
  f.puts(500)
end
File.open("time.txt", 'w') do |f|
  f.puts(500)
end

loop do
  File.open("log_16.txt", 'r') do |f|
    f.each_line do |line|
      if line.to_i < THRESHOLD && line.to_i != 0 then
        s.sendSingle(16, BLUE)
        s.update
        File.open("sound_on.txt", 'w') do |f|
          f.puts(1)
        end
        File.open("time.txt", 'w') do |f|
          f.puts(1)
        end
        start_flag = TRUE
      end
    end
  end
  break if start_flag == TRUE
end

sleep(0.5)
s.sendAll(SBLUE1)
s.update
sleep(0.5)
s.sendAll(SBLUE2)
s.update
sleep(0.5)
s.sendAll(SBLUE3)
s.update
sleep(0.5)
s.sendAll(ZERO)
s.update

# 2, 1, GO
# 2
File.open("sound_on.txt", 'w') do |f|
  f.puts(2)
end
sleep(0.5)
0.upto(28) do |num|
  if num <= 5 || num == 9 || num == 10 || num == 14 || num == 15 || num == 18 || num == 19 || num == 23 || num >= 24 then
    s.sendSingle(num, YELLOW)
    s.update
  end
end
sleep(1)
# 1
0.upto(28) do |num|
  if num == 6 || num == 7 || num == 8 || num == 11 || num == 13 || num == 16 || num == 20 || num == 21 || num == 22 then
    s.sendSingle(num, YELLOW)
    s.update
  end
end
sleep(1)
# GO
s.sendAll(LGREEN)
s.update
sleep(1)

# reset
s.sendAll(ZERO)
s.update
0.upto(28) do |num|
  if num <= 5 || num == 9 || num == 10 || num == 14 || num == 15 || num == 18 || num == 19 || num == 23 || num >= 24 then
    s.sendSingle(num, ORANGE)
    s.update
  end
end
sleep(1)

# Game Start
1.upto(STAGE) do
  ok_flag = FALSE
  # decide "on" light
  r_num[2] = r_num[1]
  r_num[1] = r_num[0]
  loop do
    r_num[0] = rand(4)
    redo if (r_num[0] == r_num[1]) && (r_num[0] == r_num[2])
    break
  end

  if r_num[0] == 0 then
    s.sendSingle(7, YELLOW)
    s.update

    File.open("log_7.txt", 'w') do |f|
      f.puts(500)
    end
  elsif r_num[0] == 1 then
    s.sendSingle(13, YELLOW)
    s.update

    File.open("log_13.txt", 'w') do |f|
      f.puts(500)
    end
  elsif r_num[0] == 2 then
    s.sendSingle(16, YELLOW)
    s.update

    File.open("log_16.txt", 'w') do |f|
      f.puts(500)
    end
  elsif r_num[0] == 3 then
    s.sendSingle(21, YELLOW)
    s.update

    File.open("log_21.txt", 'w') do |f|
      f.puts(500)
    end
  end

  # Judge touching senser
  loop do
    if r_num[0] == 0 then
      File.open("log_7.txt", 'r') do |f|
        f.each_line do |line|
          if line.to_i < THRESHOLD then
            File.open("sound_on.txt", 'w') do |f|
              f.puts(3)
            end
            s.sendSingle(7, BLUE)
            s.update
            sleep(0.5)
            s.sendSingle(7, ZERO)
            s.update
            ok_flag = TRUE
            break
          end
        end
      end
    elsif r_num[0] == 1 then
      File.open("log_13.txt", 'r') do |f|
        f.each_line do |line|
          if line.to_i < THRESHOLD then
            File.open("sound_on.txt", 'w') do |f|
              f.puts(3)
            end
            s.sendSingle(13, BLUE)
            s.update
            sleep(0.5)
            s.sendSingle(13, ZERO)
            s.update
            ok_flag = TRUE
            break
          end
        end
      end
    elsif r_num[0] == 2 then
      File.open("log_16.txt", 'r') do |f|
        f.each_line do |line|
          if line.to_i < THRESHOLD then
            File.open("sound_on.txt", 'w') do |f|
              f.puts(3)
            end
            s.sendSingle(16, BLUE)
            s.update
            sleep(0.5)
            s.sendSingle(16, ZERO)
            s.update
            ok_flag = TRUE
            break
          end
        end
      end
    elsif r_num[0] == 3 then
      File.open("log_21.txt", 'r') do |f|
        f.each_line do |line|
          if line.to_i < THRESHOLD then
            File.open("sound_on.txt", 'w') do |f|
              f.puts(3)
            end
            s.sendSingle(21, BLUE)
            s.update
            sleep(0.5)
            s.sendSingle(21, ZERO)
            s.update
            ok_flag = TRUE
            break
          end
        end
      end
    end

    break if ok_flag == TRUE
  end
end

################################
# Clear
File.open("score.txt", 'w') do |f|
  f.puts(0)
end

File.open("time.txt", 'r') do |f|
  f.each_line do |line|
    puts line
    File.open("score.txt", 'w') do |f|
      f.puts(line)
    end
  end
end

# Clear Light
File.open("sound_on.txt", 'w') do |f|
  f.puts(4)
end

0.upto(29) do |i|
  if i == 12 then
    next
  end

  if i < 5 then
    s.sendSingle(i, RED)
  elsif i < 10 then
    s.sendSingle(i, BLUE)
  elsif i < 15 then
    s.sendSingle(i, GREEN)
  elsif i < 19 then
    s.sendSingle(i, YELLOW)
  elsif i < 24 then
    s.sendSingle(i, ORANGE)
  elsif i < 29 then
    s.sendSingle(i, LGREEN)
  end
  s.update
  sleep(0.1)
end

sleep(1)

led = [10, 10, 10, 30]

s.sendAll(ZERO)
s.update
s.sendSingle(4, led)
s.update
s.sendSingle(9, led)
s.update
s.sendSingle(14, led)
s.update
s.sendSingle(18, led)
s.update
s.sendSingle(23, led)
s.update
s.sendSingle(28, led)
s.update
s.sendSingle(3, led)
s.update
s.sendSingle(8, led)
s.update
s.sendSingle(17, led)
s.update
s.sendSingle(22, led)
s.update
s.sendSingle(27, led)
s.update

s.close
