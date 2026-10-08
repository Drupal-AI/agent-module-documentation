#!/usr/bin/env bash
# Execution RESET: (re)create text format 'no_nbsp_pp' WITHOUT the No-nbsp filter, so verify
# FAILS until the agent enables it with preserve_placeholders on. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("no_nbsp_pp")) { $f->delete(); }
  FilterFormat::create(["format" => "no_nbsp_pp", "name" => "No Nbsp PP", "weight" => 20, "filters" => []])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: text format no_nbsp_pp present with no No-nbsp filter"
