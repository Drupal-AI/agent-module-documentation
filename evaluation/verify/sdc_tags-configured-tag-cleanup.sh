#!/usr/bin/env bash
# Introspection CLEANUP: remove only the sdct_known tag rule. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("sdc_tags.settings")->clear("component_tags.sdct_known")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: sdc_tags.settings component_tags.sdct_known removed"
