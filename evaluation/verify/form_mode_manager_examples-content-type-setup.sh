#!/usr/bin/env bash
# Introspection SETUP: ensure the examples submodule is enabled (it ships the demo content type
# node_form_mode_example + contributor form mode). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en form_mode_manager_examples -y >/dev/null 2>&1
echo "setup: form_mode_manager_examples enabled (provides node_form_mode_example + contributor form mode)"
