#!/usr/bin/env bash
# Introspection CLEANUP: remove the dth_fss_prov block. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\block\Entity\Block; if ($b = Block::load("dth_fss_prov")) { $b->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: block dth_fss_prov removed"
