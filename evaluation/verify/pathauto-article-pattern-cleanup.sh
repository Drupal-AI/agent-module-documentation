#!/usr/bin/env bash
# Introspection CLEANUP: remove the known eval_article pathauto_pattern, restoring baseline.
# Idempotent: no-op if already gone. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("pathauto_pattern");
  if ($p = $storage->load("eval_article")) { $p->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: pathauto_pattern eval_article removed"
