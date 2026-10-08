#!/usr/bin/env bash
# Introspection SETUP: seed the snapshot storage (previous) and active storage (customized) for
# config_merge_filter_eval.data so that driving the config_merge filter's filterRead with new
# incoming data shows the customization is retained. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::service("config.storage.snapshot")->write("config_merge_filter_eval.data", ["n" => 1, "label" => "base"]);
  \Drupal::service("config.storage")->write("config_merge_filter_eval.data", ["n" => 50, "label" => "base"]);
' >/dev/null 2>&1
echo "setup: snapshot n=1, active n=50 for config_merge_filter_eval.data"
