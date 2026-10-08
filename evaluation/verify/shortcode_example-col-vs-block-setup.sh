#!/usr/bin/env bash
# Introspection SETUP: create a namespaced text format `sce_toggle` with the `shortcode` filter
# enabled and exactly one of col/block turned on (col=true, block=false), so an inspecting
# agent can read back which one is active. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("sce_toggle")) { $f->delete(); }
  FilterFormat::create([
    "format" => "sce_toggle",
    "name" => "Shortcode Example Eval (col vs block)",
    "filters" => [
      "shortcode" => ["status" => TRUE, "weight" => 0, "settings" => ["col" => TRUE, "block" => FALSE]],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: sce_toggle has col=true, block=false"
