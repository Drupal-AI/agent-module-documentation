#!/usr/bin/env bash
# Execution VERIFY: PASS when field_ec_task's default view display formatter is
# email_contact_link. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_ec_task") : NULL;
  $type = $c["type"] ?? "none";
  $ok = ($type === "email_contact_link");
  print ($ok ? "PASS" : "FAIL") . " formatter=$type\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
