#!/bin/bash

mix deps.get

npm install
truffle compile && truffle migrate
mix phx.server