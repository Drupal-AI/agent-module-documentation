#!/usr/bin/env bash
# Execution RESET: delete any view_mode_page pattern whose path pattern is /%/summary so verify
# FAILS on empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("view_mode_page_pattern");
  foreach ($s->loadMultiple() as $p) {
    if ($p->get("pattern") === "/%/summary") { $p->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: removed patterns with pattern=/%/summary"
