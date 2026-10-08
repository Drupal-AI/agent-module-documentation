#!/usr/bin/env bash
# Execution RESET: (re)create the namespaced text format `shortcode_task` with NO shortcode
# filter configured at all, so verify FAILS until the agent enables it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("shortcode_task")) { $f->delete(); }
  FilterFormat::create([
    "format" => "shortcode_task",
    "name" => "Shortcode Task",
    "filters" => [],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: shortcode_task exists with no shortcode filter configured"
