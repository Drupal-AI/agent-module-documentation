#!/usr/bin/env bash
# Introspection SETUP: create a namespaced text format `sbt_eval` with the `shortcode` filter
# enabled at an unusual weight (17) and the `quote`/`button` shortcode_basic_tags tags on, so an
# inspecting agent can read the weight back from live config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("sbt_eval")) { $f->delete(); }
  FilterFormat::create([
    "format" => "sbt_eval",
    "name" => "Shortcode Basic Tags Eval (weight)",
    "filters" => [
      "shortcode" => ["status" => TRUE, "weight" => 17, "settings" => ["quote" => TRUE, "button" => TRUE]],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: sbt_eval has shortcode filter enabled at weight=17"
