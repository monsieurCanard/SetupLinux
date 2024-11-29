#!/bin/bash

chmod +x setup_files/setup_all_language.sh
chmod +x setup_files/setup_terminal.sh
chmod +x setup_files/setup_essential.sh
chmod +x setup_files/setup_docker.sh

./setup_files/setup_essential.sh
wait $!
./setup_files/setup_all_language.sh
wait $!
./setup_files/setup_docker.sh
wait $!
./setup_files/setup_terminal.sh