rm -r -f log_7.txt log_13.txt log_16.txt log_21.txt sound_on.txt time.txt score.txt &
gnome-terminal -x java gui &
gnome-terminal -x java sound &
gnome-terminal -x ruby timer.rb &
gnome-terminal -x ./run &
ruby Light.rb
