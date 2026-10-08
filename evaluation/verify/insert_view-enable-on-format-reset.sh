#!/usr/bin/env bash
# Execution RESET: ensure the text format iv_task exists with the Insert View filter explicitly
# DISABLED, so verify FAILS until the agent enables it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("filter_format");
  if (!$storage->load("iv_task")) {
    $storage->create(["format" => "iv_task", "name" => "IV Task format", "weight" => 43])->save();
  }
  $fmt = $storage->load("iv_task");
  $fmt->setFilterConfig("insert_view", ["id" => "insert_view", "provider" => "insert_view", "status" => FALSE, "weight" => 0, "settings" => []]);
  $fmt->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: filter_format iv_task exists with insert_view status=FALSE"
