#!/usr/bin/env bash
# Introspection SETUP: create a namespaced text format `shortcode_eval2` with the `shortcode`
# filter enabled and exactly one of quote/highlight turned on (quote=true, highlight=false), so
# an inspecting agent can read back which one is active. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("shortcode_eval2")) { $f->delete(); }
  FilterFormat::create([
    "format" => "shortcode_eval2",
    "name" => "Shortcode Eval (quote vs highlight)",
    "filters" => [
      "shortcode" => ["status" => TRUE, "weight" => 0, "settings" => ["quote" => TRUE, "highlight" => FALSE]],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: shortcode_eval2 has quote=true, highlight=false"
