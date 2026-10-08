#!/usr/bin/env bash
# Introspection CLEANUP: delete the smm_known bundle. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\simple_megamenu\Entity\SimpleMegaMenuType;
  if ($t = SimpleMegaMenuType::load("smm_known")) { $t->delete(); }
' >/dev/null 2>&1
echo "cleanup: smm_known removed"
