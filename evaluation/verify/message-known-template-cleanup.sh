#!/usr/bin/env bash
# Introspection CLEANUP: remove the known eval_activity message_template, restoring baseline.
# Idempotent: no-op if already gone. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("message_template");
  if ($t = $storage->load("eval_activity")) { $t->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: message_template eval_activity removed"
