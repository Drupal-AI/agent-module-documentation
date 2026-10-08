#!/usr/bin/env bash
# Introspection SETUP: create a text format md_enabled whose Markdown filter is enabled and
# uses the 'commonmark' parser, so an agent can read the configured parser back. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("md_enabled")) { $f->delete(); }
  FilterFormat::create([
    "format" => "md_enabled", "name" => "MD Enabled",
    "filters" => ["markdown" => ["status" => 1, "settings" => ["id" => "commonmark"]]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: text format md_enabled uses Markdown filter with parser commonmark"
