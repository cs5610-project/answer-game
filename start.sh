#!/bin/bash

export PORT=5104

cd ~/www/gameproject
./bin/gameproject stop || true
./bin/gameproject start

