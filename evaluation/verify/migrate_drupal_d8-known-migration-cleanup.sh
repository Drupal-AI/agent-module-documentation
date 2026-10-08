#!/usr/bin/env bash
# Introspection CLEANUP: delete the known migration created by setup (leaves migrate_plus enabled,
# which is harmless). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\migrate_plus\Entity\Migration; if (Migration::load("mdd8_known")) { Migration::load("mdd8_known")->delete(); }' >/dev/null 2>&1
echo "cleanup: migration mdd8_known removed"
