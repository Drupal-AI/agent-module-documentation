#!/usr/bin/env bash
# Execution VERIFY: PASS when field_pi_task's widget on node.article.default is
# phone_international_widget with settings.initial_country === GB. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $c = $fd ? $fd->getComponent("field_pi_task") : NULL;
  $type = $c["type"] ?? "none";
  $ic = $c["settings"]["initial_country"] ?? "";
  $ok = ($type === "phone_international_widget" && $ic === "GB");
  print ($ok ? "PASS" : "FAIL") . " widget=" . $type . " initial_country=" . var_export($ic, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
