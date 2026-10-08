#!/usr/bin/env bash
# Execution CLEANUP: delete any pattern with pattern=/%/print. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("view_mode_page_pattern");
  foreach ($s->loadMultiple() as $p) { if ($p->get("pattern") === "/%/print") { $p->delete(); } }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: removed patterns with pattern=/%/print"
