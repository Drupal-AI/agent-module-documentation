#!/usr/bin/env bash
# Execution VERIFY: PASS when the block display block_1 of view vbfb_task has
# exposed_block enabled AND core's deriver therefore offers the block plugin
# views_exposed_filter_block:vbfb_task-block_1. exit 0 = pass, 1 = fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::entityTypeManager()->getStorage("view")->load("vbfb_task");
  $eb = $v ? ($v->getDisplay("block_1")["display_options"]["exposed_block"] ?? NULL) : NULL;
  \Drupal::service("plugin.manager.block")->clearCachedDefinitions();
  $has = isset(\Drupal::service("plugin.manager.block")->getDefinitions()["views_exposed_filter_block:vbfb_task-block_1"]);
  $ok = !empty($eb) && $has;
  print ($ok ? "PASS" : "FAIL") . " exposed_block=" . var_export($eb, TRUE) . " block_plugin=" . var_export($has, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
