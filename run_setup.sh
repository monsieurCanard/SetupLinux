#!/bin/bash

chmod +x setup_file/setup_all_language.sh
chmod +x setup_file/setup_terminal.sh
chmod +x setup_file/setup_essential.sh

./setup_file/setup_essential.sh
wait $!
./setup_file/setup_all_language.sh
wait $!
./setup_file/setup_terminal.sh