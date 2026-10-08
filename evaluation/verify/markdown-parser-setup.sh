#!/usr/bin/env bash
# Introspection SETUP: create a text format md_probe whose Markdown filter is enabled and uses
# the 'parsedown' parser, so an agent can read the configured parser back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("md_probe")) { $f->delete(); }
  FilterFormat::create([
    "format" => "md_probe", "name" => "MD Probe",
    "filters" => ["markdown" => ["status" => 1, "settings" => ["id" => "parsedown"]]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: text format md_probe uses Markdown filter with parser parsedown"
