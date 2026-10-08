#!/usr/bin/env bash
# Introspection CLEANUP: delete the eca_crowdsec_known model. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\eca\Entity\Eca;
  if ($e = Eca::load("eca_crowdsec_known")) { $e->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: eca model eca_crowdsec_known removed"
