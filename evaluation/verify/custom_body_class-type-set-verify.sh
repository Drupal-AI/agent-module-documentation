#!/usr/bin/env bash
# Execution VERIFY: PASS when the Article node type third-party setting
# custom_body_class.classes == "campaign-2026".
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $t = \Drupal::entityTypeManager()->getStorage("node_type")->load("article");
  $v = $t->getThirdPartySetting("custom_body_class", "classes", "");
  $ok = ($v === "campaign-2026");
  print ($ok ? "PASS" : "FAIL") . " classes=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
