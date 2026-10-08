#!/usr/bin/env bash
# Execution VERIFY (auto_entityqueue auto-add): PASS when entityqueue aeq_task has
# auto_entityqueue.auto_add enabled. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\entityqueue\Entity\EntityQueue;
  $q = EntityQueue::load("aeq_task");
  $es = $q ? $q->getEntitySettings() : [];
  $aa = $es["handler_settings"]["auto_entityqueue"]["auto_add"] ?? NULL;
  $ok = !empty($aa);
  print ($ok ? "PASS" : "FAIL") . " auto_add=" . var_export($aa, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
