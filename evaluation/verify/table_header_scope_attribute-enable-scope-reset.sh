#!/usr/bin/env bash
# Execution RESET: create text format 'thsa_exec' with NO THSA filters, so verify FAILS until the
# agent enables the scope-attribute filter on it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("thsa_exec")) { $f->delete(); }
  FilterFormat::create(["format"=>"thsa_exec","name"=>"THSA Exec","filters"=>[]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: text format thsa_exec created with no THSA filters"
