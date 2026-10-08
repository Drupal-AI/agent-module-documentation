#!/usr/bin/env bash
# Reset state for the workbench_access "build a menu access scheme" hard/execution case so
# each run starts clean: delete the section_menu access_scheme if a previous run created it.
# Scoped to section_menu only, so any other schemes are left untouched.
# Idempotent: a no-op if section_menu does not exist.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($e = \Drupal::entityTypeManager()->getStorage("access_scheme")->load("section_menu")) { $e->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: access_scheme 'section_menu' deleted"
