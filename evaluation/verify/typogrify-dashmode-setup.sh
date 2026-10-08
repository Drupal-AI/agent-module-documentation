#!/usr/bin/env bash
# Introspection SETUP: create text format 'typogrify_eval2' with Typogrify enabled and a known
# dash mode (smartypants_hyphens = 2), so an agent can read the live setting value. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if (!FilterFormat::load("typogrify_eval2")) {
    $f = FilterFormat::create(["format"=>"typogrify_eval2","name"=>"Typogrify Eval 2","weight"=>50]);
  } else {
    $f = FilterFormat::load("typogrify_eval2");
  }
  $f->setFilterConfig("typogrify", ["status"=>TRUE, "weight"=>10, "settings"=>["smartypants_hyphens"=>2]]);
  $f->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: typogrify_eval2 Typogrify filter smartypants_hyphens=2"
