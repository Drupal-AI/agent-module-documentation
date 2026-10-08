#!/usr/bin/env bash
# Execution CLEANUP: delete ka_task_priv and remove the temp PEM. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\key\Entity\Key; if ($k=Key::load("ka_task_priv")) $k->delete();' >/dev/null 2>&1
rm -f /tmp/key_asymmetric_task_priv.pem
drush cr >/dev/null 2>&1
echo "cleanup: ka_task_priv removed"
