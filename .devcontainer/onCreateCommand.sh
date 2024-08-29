#!/usr/bin/env bash

ARCH="$(dpkg --print-architecture)"

# Grafana
curl -sS https://apt.grafana.com/gpg.key | sudo gpg --dearmor --output /usr/share/keyrings/grafana.gpg \
  && echo "deb [signed-by=/usr/share/keyrings/grafana.gpg] https://apt.grafana.com stable main" | sudo tee /etc/apt/sources.list.d/grafana.list

sudo apt-get update && sudo apt-get install -y \
  alloy \
  bash-completion

echo "
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

source <(alloy completion bash)
" >>~/.bashrc
