#!/usr/bin/env bash
# Execution VERIFY: PASS when filter_format 'ec_task_format' exists and its embedded_content filter is
# enabled (status true). Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  $f = FilterFormat::load("ec_task_format");
  $status = "none";
  if ($f) {
    $cfg = $f->filters("embedded_content")->getConfiguration();
    $status = !empty($cfg["status"]) ? "on" : "off";
  }
  $ok = ($status === "on");
  print ($ok ? "PASS" : "FAIL") . " format=" . ($f ? "exists" : "missing") . " embedded_content=" . $status . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
