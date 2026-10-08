#!/usr/bin/env bash
# Introspection CLEANUP: delete ka_probe_pub and ka_probe_priv2. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\key\Entity\Key; foreach(["ka_probe_pub","ka_probe_priv2"] as $id){ if($k=Key::load($id)) $k->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: ka_probe_pub / ka_probe_priv2 removed"
