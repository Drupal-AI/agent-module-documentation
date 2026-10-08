#!/usr/bin/env bash
# Execution RESET: ensure the task dashboards are absent so verify FAILS until the agent builds them.
set -uo pipefail
cd /var/www/html
drush php:eval '
$s=\Drupal::entityTypeManager()->getStorage("dashboard");
foreach (["ds_task_a","ds_task_b"] as $id) { if ($d=$s->load($id)) $d->delete(); }
' >/dev/null 2>&1
echo "reset: ds_task_a / ds_task_b absent"
