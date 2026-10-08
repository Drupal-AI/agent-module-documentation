#!/usr/bin/env bash
# Execution VERIFY: PASS when the iva_eval_hard format has the insert_view_adv filter enabled
# (filters.insert_view_adv.status === TRUE). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $f = \Drupal::entityTypeManager()->getStorage("filter_format")->load("iva_eval_hard");
  $status = NULL;
  if ($f) {
    $filters = $f->get("filters");
    $status = $filters["insert_view_adv"]["status"] ?? NULL;
  }
  $ok = ($status === TRUE || $status === 1 || $status === "1");
  print ($ok ? "PASS" : "FAIL") . " insert_view_adv.status=" . var_export($status, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
