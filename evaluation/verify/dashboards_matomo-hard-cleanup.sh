#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '$s=\Drupal::entityTypeManager()->getStorage("dashboard"); foreach (["dm_task_a","dm_task_b"] as $id) { if ($d=$s->load($id)) $d->delete(); }' >/dev/null 2>&1
echo "cleanup: dm_task_a / dm_task_b removed"
