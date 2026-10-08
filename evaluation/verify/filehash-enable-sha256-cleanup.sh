#!/usr/bin/env bash
# Execution CLEANUP: disable SHA-256 and drop its column to restore baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("filehash.settings");
  $a = $c->get("algorithms"); $a["sha256"] = FALSE; $c->set("algorithms", $a)->save();
' >/dev/null 2>&1
drush filehash:clean >/dev/null 2>&1
echo "cleanup: filehash sha256 disabled, column dropped (baseline)"
