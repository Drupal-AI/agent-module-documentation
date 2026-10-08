#!/usr/bin/env bash
# Execution CLEANUP: restore defaults (bcc_active=FALSE, bcc_email="").
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("commerce_abandoned_carts.settings")->set("bcc_active", FALSE)->set("bcc_email", "")->save();' >/dev/null 2>&1
echo "cleanup: bcc_active=FALSE bcc_email="
