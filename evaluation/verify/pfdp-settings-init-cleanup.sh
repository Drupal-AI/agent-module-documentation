#!/usr/bin/env bash
# Execution CLEANUP: delete pfdp.settings again, restoring the post-install baseline of this
# module (the object does not exist). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("pfdp.settings")->delete(); print "cleaned\n";' 2>/dev/null
echo "cleanup: pfdp.settings removed"
