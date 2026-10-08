#!/usr/bin/env bash
# Introspection CLEANUP: remove the known Eval Zone / Eval Lounge forum terms, restoring baseline.
# Idempotent: no-op if already gone. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("taxonomy_term");
  foreach (["Eval Lounge", "Eval Zone"] as $name) {
    foreach ($storage->loadByProperties(["vid" => "forums", "name" => $name]) as $t) { $t->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: Eval Zone / Eval Lounge forum terms removed"
