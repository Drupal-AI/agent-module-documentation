#!/usr/bin/env bash
# Execution VERIFY: PASS when field_da_recurring's component carries date_augmenter settings that
# enable at least one augmenter on the 'rule' set (recurring-rule dates).
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_da_recurring") : NULL;
  $rule = $c["third_party_settings"]["date_augmenter"]["rule"]["status"] ?? [];
  $enabled = array_filter((array) $rule);
  $ok = !empty($enabled);
  print ($ok ? "PASS" : "FAIL") . " rule_enabled=" . implode(",", array_keys($enabled)) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
