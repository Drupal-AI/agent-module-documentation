#!/usr/bin/env bash
# Execution VERIFY: PASS when node.article.default has smart_title third-party setting
# enabled === TRUE and a visible smart_title component. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $enabled = $vd ? $vd->getThirdPartySetting("smart_title", "enabled") : NULL;
  $comp = $vd ? $vd->getComponent("smart_title") : NULL;
  $ok = ($enabled === TRUE && !empty($comp));
  print ($ok ? "PASS" : "FAIL") . " enabled=" . var_export($enabled, TRUE) . " component=" . (!empty($comp) ? "yes" : "no") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
