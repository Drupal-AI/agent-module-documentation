#!/usr/bin/env bash
# Execution RESET: ensure text format ace_editor_h2 exists with the Ace Filter DISABLED/absent,
# so verify FAILS until the agent enables ace_filter with syntax=ruby. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("ace_editor_h2")) { $f->delete(); }
  FilterFormat::create(["format" => "ace_editor_h2", "name" => "Ace Editor H2"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: format ace_editor_h2 present, ace_filter not enabled"
