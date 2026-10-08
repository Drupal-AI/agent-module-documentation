#!/usr/bin/env bash
# Execution VERIFY: PASS when field_da_task's component on node.article.default carries
# date_augmenter third-party settings with at least one enabled (truthy status) augmenter.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_da_task") : NULL;
  $da = $c["third_party_settings"]["date_augmenter"] ?? [];
  // Collect all status arrays whether stored flat or under instances/rule sets.
  $statuses = [];
  if (isset($da["status"])) { $statuses = array_merge($statuses, (array) $da["status"]); }
  foreach (["instances","rule"] as $set) { if (isset($da[$set]["status"])) { $statuses = array_merge($statuses, (array) $da[$set]["status"]); } }
  $enabled = array_filter($statuses);
  $ok = !empty($enabled);
  print ($ok ? "PASS" : "FAIL") . " enabled=" . implode(",", array_keys($enabled)) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
