#!/usr/bin/env bash
# Execution RESET: (re)create text format 'no_nbsp_hard' WITHOUT the No-nbsp filter, so verify
# FAILS until the agent enables filter_no_nbsp on it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("no_nbsp_hard")) { $f->delete(); }
  FilterFormat::create(["format" => "no_nbsp_hard", "name" => "No Nbsp Hard", "weight" => 20, "filters" => []])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: text format no_nbsp_hard present with no No-nbsp filter"
