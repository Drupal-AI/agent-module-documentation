#!/usr/bin/env bash
# Introspection SETUP: create a namespaced text format `sbt_toggle` with the `shortcode` filter
# enabled and exactly one of quote/highlight turned on (quote=true, highlight=false), so an
# inspecting agent can read back which one is active. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("sbt_toggle")) { $f->delete(); }
  FilterFormat::create([
    "format" => "sbt_toggle",
    "name" => "Shortcode Basic Tags Eval (quote vs highlight)",
    "filters" => [
      "shortcode" => ["status" => TRUE, "weight" => 0, "settings" => ["quote" => TRUE, "highlight" => FALSE]],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: sbt_toggle has quote=true, highlight=false"
