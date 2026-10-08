#!/usr/bin/env bash
# Introspection CLEANUP: disable SHA-256 and drop its column (filehash:clean) to restore the
# shipped baseline (no algorithms enabled). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("filehash.settings");
  $a = $c->get("algorithms"); $a["sha256"] = FALSE; $c->set("algorithms", $a)->save();
' >/dev/null 2>&1
drush filehash:clean >/dev/null 2>&1
echo "cleanup: filehash.settings algorithms.sha256=false and column dropped"
