#!/usr/bin/env bash
# Execution CLEANUP: delete ka_task_pub and ka_task_priv2 and the temp PEM. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\key\Entity\Key; foreach(["ka_task_pub","ka_task_priv2"] as $id){ if($k=Key::load($id)) $k->delete(); }' >/dev/null 2>&1
rm -f /tmp/key_asymmetric_task_pub.pem
drush cr >/dev/null 2>&1
echo "cleanup: ka_task_pub / ka_task_priv2 removed"
