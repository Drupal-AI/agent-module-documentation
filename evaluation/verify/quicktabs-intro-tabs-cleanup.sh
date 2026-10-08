#!/usr/bin/env bash
# Introspection CLEANUP: remove the known eval_intro_tabs quicktabs_instance,
# restoring baseline. Idempotent: no-op if already gone. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $qt = \Drupal::entityTypeManager()->getStorage("quicktabs_instance")->load("eval_intro_tabs");
  if ($qt) { $qt->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: quicktabs_instance eval_intro_tabs removed"
