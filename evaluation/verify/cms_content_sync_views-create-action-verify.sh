#!/usr/bin/env bash
# Execution VERIFY: PASS when action ccs_views_task_action exists with type
# cms_content_sync_entity_status and plugin export_status_entity. Exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $a = \Drupal::entityTypeManager()->getStorage("action")->load("ccs_views_task_action");
  $type = $a ? $a->getType() : NULL;
  $plugin = $a ? $a->get("plugin") : NULL;
  $ok = ($a && $type === "cms_content_sync_entity_status" && $plugin === "export_status_entity");
  print ($ok ? "PASS" : "FAIL") . " type=" . var_export($type, TRUE) . " plugin=" . var_export($plugin, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
