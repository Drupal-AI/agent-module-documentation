#!/usr/bin/env bash
# Execution VERIFY: PASS when ref column widget == entity_reference_entity_browser.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd=\Drupal::service("entity_display.repository")->getFormDisplay("node","cfeb_eval","default");
  $c=$fd->getComponent("field_cfeb_ref");
  $w=$c["settings"]["fields"]["ref"]["type"] ?? "none";
  print (($w==="entity_reference_entity_browser")?"PASS":"FAIL")." widget=".$w."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
