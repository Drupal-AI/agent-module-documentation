#!/usr/bin/env bash
# Introspection SETUP: create a namespaced text format `shortcode_eval` with the `shortcode`
# filter enabled at an unusual weight (13) and the `quote` shortcode enabled, so an inspecting
# agent can read the weight back from live config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("shortcode_eval")) { $f->delete(); }
  FilterFormat::create([
    "format" => "shortcode_eval",
    "name" => "Shortcode Eval (weight)",
    "filters" => [
      "shortcode" => ["status" => TRUE, "weight" => 13, "settings" => ["quote" => TRUE]],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: shortcode_eval has shortcode filter enabled at weight=13"
