# my-stats

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

An experiment collecting a small amount of personal metrics via GitHub Actions.

This repository demonstrates how to scrape and send a small amount of metrics on demand from GitHub Actions to a remote metrics store using [Grafana Alloy](https://grafana.com/docs/alloy/latest/) and [theduke/prom-write](https://github.com/theduke/prom-write).

## 👀 How it works

The workflow is simple:

![Workflow diagram](docs/workflow-diagram.png)

1. Set up the metrics collection environment via Docker Compose (see [docker-compose.yaml](docker-compose.yaml)).
2. Scrape metrics from exporters using `curl`.
3. Push metrics to Grafana Alloy via `prom-write`.
4. Alloy pushes metrics (flushing its buffer on teardown) to the remote metrics store using the Prometheus Remote Write API.

## 🔧 For your own experiment

To use this repository for your own experiment, you need:

### 🐳 System requirements

The following tools must be installed on your system:

- Docker and Docker Compose

### ❄️ Tools managed via Nix Flakes

This repository uses [Nix Flakes](https://nix.dev/concepts/flakes.html) to manage tools. The following tools will be automatically installed (you must have `nix` installed):

- `pre-commit`
- [Grafana Alloy](https://grafana.com/docs/alloy/latest/) (`alloy`)
- [theduke/prom-write](https://github.com/theduke/prom-write) (`prom-write`)

Run `nix develop` to activate the environment. This will automatically install the above tools.

If you prefer [Dev Container](https://containers.dev/), there is configuration available in [./.devcontainer.example/devcontainer.json](./.devcontainer.example/devcontainer.json) with Nix installed.

### 🧪 Set up and testing

1. Copy `.env.example` to `.env` and update it with your own values.
2. Run `docker compose up --detach` to start the environment.
3. Run `nix develop` to install the required tools.

## 📜 License

This project is licensed under the MIT License.
