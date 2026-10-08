#!/usr/bin/env bash
# Execution VERIFY: PASS when an Article titled 'FTVNODE-alpha' exists whose field_ftv_auto value
# equals 'FTV:FTVNODE-alpha' (proves the presave token replacement ran). Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ids = \Drupal::entityTypeManager()->getStorage("node")->getQuery()
    ->accessCheck(FALSE)->condition("type","article")->condition("title","FTVNODE-alpha")->execute();
  $val = "";
  if (!empty($ids)) {
    $node = \Drupal::entityTypeManager()->getStorage("node")->load(reset($ids));
    $val = $node->hasField("field_ftv_auto") ? (string) $node->get("field_ftv_auto")->value : "";
  }
  $ok = ($val === "FTV:FTVNODE-alpha");
  print ($ok ? "PASS" : "FAIL") . " field_ftv_auto=" . var_export($val, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
