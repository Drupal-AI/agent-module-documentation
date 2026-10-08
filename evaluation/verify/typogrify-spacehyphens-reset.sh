#!/usr/bin/env bash
# Execution RESET: create text format 'typogrify_eval_h2' with Typogrify enabled but
# space_hyphens = 0, so verify FAILS until the agent turns stand-alone-dash -> em-dash on.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("typogrify_eval_h2")) { $f->delete(); }
  $f = FilterFormat::create(["format"=>"typogrify_eval_h2","name"=>"Typogrify Eval H2","weight"=>50]);
  $f->setFilterConfig("typogrify", ["status"=>TRUE, "weight"=>10, "settings"=>["space_hyphens"=>0]]);
  $f->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: typogrify_eval_h2 Typogrify enabled with space_hyphens=0"
