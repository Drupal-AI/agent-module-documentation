#!/usr/bin/env bash
# Execution RESET: (re)create text format buty_task with the Bootstrap Utilities image filter
# DISABLED/absent, so verify FAILS until the agent enables it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  $f = FilterFormat::load("buty_task");
  if (!$f) {
    $f = FilterFormat::create(["format" => "buty_task", "name" => "BUTY Task", "weight" => 41]);
  }
  $f->setFilterConfig("bootstrap_utilities_image_filter", ["status" => FALSE, "weight" => 10, "settings" => []]);
  $f->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: text format buty_task exists with bootstrap_utilities_image_filter disabled"
