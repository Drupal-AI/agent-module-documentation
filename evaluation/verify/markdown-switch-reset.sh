#!/usr/bin/env bash
# Execution RESET: (re)create text format md_switch with the Markdown filter enabled using the
# 'commonmark' parser, so verify FAILS until the agent switches it to parsedown. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("md_switch")) { $f->delete(); }
  FilterFormat::create([
    "format" => "md_switch", "name" => "MD Switch",
    "filters" => ["markdown" => ["status" => 1, "settings" => ["id" => "commonmark"]]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: md_switch Markdown filter uses parser commonmark"
