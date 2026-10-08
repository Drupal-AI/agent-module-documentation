#!/usr/bin/env bash
# Execution RESET: create text format 'typogrify_eval_h' WITHOUT the Typogrify filter, so verify
# FAILS until the agent enables Typogrify on it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("typogrify_eval_h")) { $f->delete(); }
  FilterFormat::create(["format"=>"typogrify_eval_h","name"=>"Typogrify Eval H","weight"=>50])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: text format typogrify_eval_h exists WITHOUT the Typogrify filter"
