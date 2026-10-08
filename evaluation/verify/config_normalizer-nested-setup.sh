#!/usr/bin/env bash
# Introspection SETUP: write config_normalizer_eval.nested to active storage with an unsorted
# nested associative array under 'group', so reading it normalized (compare mode) shows the
# 'sort' normalizer sorts nested keys recursively. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("config_normalizer_eval.nested")
    ->setData(["group" => ["yankee" => 1, "alpha" => 2, "mike" => 3]])->save();
' >/dev/null 2>&1
echo "setup: config_normalizer_eval.nested written (group keys yankee,alpha,mike)"
