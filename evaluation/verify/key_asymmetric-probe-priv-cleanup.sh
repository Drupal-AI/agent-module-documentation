#!/usr/bin/env bash
# Introspection CLEANUP: delete the ka_probe_priv key. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\key\Entity\Key; if ($k=Key::load("ka_probe_priv")) $k->delete();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: ka_probe_priv removed"
