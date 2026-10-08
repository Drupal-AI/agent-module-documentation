#!/usr/bin/env bash
# Execution CLEANUP: delete the task dashboards. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
$s=\Drupal::entityTypeManager()->getStorage("dashboard");
foreach (["dw_task_a","dw_task_b"] as $id) { if ($d=$s->load($id)) $d->delete(); }
' >/dev/null 2>&1
echo "cleanup: dw_task_a / dw_task_b removed"
