#!/usr/bin/env bash
# Introspection SETUP: create TWO text formats - iv_probe with the Insert View filter ENABLED
# (weight 7) and iv_plain without it - so the agent must read the live filter_format config to
# say which format can expand [view:...] tags. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("filter_format");
  if (!$storage->load("iv_probe")) {
    $storage->create(["format" => "iv_probe", "name" => "IV Probe format", "weight" => 40])->save();
  }
  if (!$storage->load("iv_plain")) {
    $storage->create(["format" => "iv_plain", "name" => "IV Plain format", "weight" => 41])->save();
  }
  $probe = $storage->load("iv_probe");
  $probe->setFilterConfig("insert_view", ["id" => "insert_view", "provider" => "insert_view", "status" => TRUE, "weight" => 7, "settings" => []]);
  $probe->save();
  $plain = $storage->load("iv_plain");
  $plain->setFilterConfig("insert_view", ["id" => "insert_view", "provider" => "insert_view", "status" => FALSE, "weight" => 7, "settings" => []]);
  $plain->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: filter_format iv_probe has insert_view status=TRUE weight=7; iv_plain has it disabled"
