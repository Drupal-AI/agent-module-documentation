#!/usr/bin/env bash
# Execution RESET: ensure a text format nrf_task exists WITHOUT the noreferrer filter enabled,
# so verify FAILS until the agent enables it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  $f = FilterFormat::load("nrf_task");
  if (!$f) {
    $f = FilterFormat::create(["format" => "nrf_task", "name" => "NRF Task"]);
  }
  // Force the noreferrer filter OFF.
  $f->setFilterConfig("noreferrer", ["status" => FALSE, "weight" => 10]);
  $f->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: text format nrf_task present with noreferrer filter DISABLED"
