#!/usr/bin/env bash
# Introspection CLEANUP: restore shipped default allowed_hosts. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("media_qualtrics.settings")
    ->set("allowed_hosts", ["https://qualtrics.com"])->save();
' >/dev/null 2>&1
echo "cleanup: media_qualtrics allowed_hosts reset to [https://qualtrics.com]"
