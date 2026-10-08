#!/usr/bin/env bash
# Introspection SETUP: create a text format 'typogrify_eval' with the Typogrify filter enabled,
# so an agent can find which format uses Typogrify. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if (!FilterFormat::load("typogrify_eval")) {
    $f = FilterFormat::create(["format"=>"typogrify_eval","name"=>"Typogrify Eval","weight"=>50]);
  } else {
    $f = FilterFormat::load("typogrify_eval");
  }
  $f->setFilterConfig("typogrify", ["status"=>TRUE, "weight"=>10]);
  $f->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: text format typogrify_eval has the Typogrify filter enabled"
