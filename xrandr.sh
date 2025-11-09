echo "Setting up 1360x768 resolution ..."
sudo cvt 1360 768
sudo xrandr --newmode "1360x768_60.00" 85.50 1360 1432 1568 1776 768 771 781 798 -hsync +vsync
sudo xrandr --addmode Virtual1 "1360x768_60.00"
sudo xrandr --output Virtual1 --mode "1360x768_60.00"
echo "Should not see any errors above this line!"