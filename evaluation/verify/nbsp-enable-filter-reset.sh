#!/usr/bin/env bash
# Execution RESET: (re)create text format nbsp_task WITHOUT the NBSP cleanup filter, so verify
# FAILS until the agent enables nbsp_cleaner_filter on it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("nbsp_task")) { $f->delete(); }
  FilterFormat::create(["format"=>"nbsp_task","name"=>"NBSP Task","filters"=>[]])->save();
' >/dev/null 2>&1
echo "reset: filter.format.nbsp_task has no nbsp_cleaner_filter"
