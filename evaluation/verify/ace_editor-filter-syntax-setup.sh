#!/usr/bin/env bash
# Introspection SETUP: create a text format ace_editor_m2 with the Ace Filter (ace_filter)
# enabled and a known default syntax (python), so an agent can read back which format has the
# filter and what language it highlights by default. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("ace_editor_m2")) { $f->delete(); }
  FilterFormat::create([
    "format" => "ace_editor_m2", "name" => "Ace Editor M2",
    "filters" => ["ace_filter" => ["status" => 1, "settings" => ["syntax" => "python", "theme" => "cobalt"]]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: text format ace_editor_m2 has ace_filter enabled with settings.syntax=python"
