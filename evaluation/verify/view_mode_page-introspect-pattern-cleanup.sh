#!/usr/bin/env bash
# Introspection CLEANUP: remove vmp_alt pattern. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("view_mode_page_pattern");
  if ($p = $s->load("vmp_alt")) { $p->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: vmp_alt removed"
