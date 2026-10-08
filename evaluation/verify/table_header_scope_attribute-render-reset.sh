#!/usr/bin/env bash
# Execution RESET: create text format 'thsa_render' with NO THSA filters, so rendering a sample
# table through it produces no scope attributes (verify FAILS) until the agent enables both
# filters in the correct order. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("thsa_render")) { $f->delete(); }
  FilterFormat::create(["format"=>"thsa_render","name"=>"THSA Render","filters"=>[]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: text format thsa_render created with no THSA filters"
