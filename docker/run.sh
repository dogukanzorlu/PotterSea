#!/bin/bash

mix deps.clean --all
mix deps.unlock --all
mix deps.get

npm install
truffle compile && truffle migrate
mix phx.server