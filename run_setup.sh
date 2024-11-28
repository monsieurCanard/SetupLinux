./setup.sh
wait $!
echo "Setup done."
echo "You need to restart your terminal."
echo "Press any key to continue..."
read -n 1 -s
sudo reboot
exit 0
