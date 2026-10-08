#!/usr/bin/env bash
# Introspection CLEANUP: delete option cpub_known (uninstalls its node base field). Restores
# baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\custom_pub\Entity\CustomPublishingOption;
  if ($o=CustomPublishingOption::load("cpub_known")) { $o->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: custom_publishing_option cpub_known removed"
