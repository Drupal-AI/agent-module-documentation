#!/usr/bin/env bash
# Execution RESET: force SHA-256 OFF and drop its column, so verify FAILS until the agent
# enables it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("filehash.settings");
  $a = $c->get("algorithms"); $a["sha256"] = FALSE; $c->set("algorithms", $a)->save();
' >/dev/null 2>&1
drush filehash:clean >/dev/null 2>&1
echo "reset: filehash sha256 disabled, column absent"
