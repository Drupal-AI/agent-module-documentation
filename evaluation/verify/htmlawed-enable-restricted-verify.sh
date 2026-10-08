#!/usr/bin/env bash
# Execution VERIFY: PASS when filter_htmlawed on htmlawed_task is enabled AND its config
# restricts elements to include a, p and strong. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  $f = FilterFormat::load("htmlawed_task");
  $cfg = $f ? $f->filters("filter_htmlawed")->getConfiguration() : NULL;
  $status = $cfg["status"] ?? FALSE;
  $c = strtolower($cfg["settings"]["config"] ?? "");
  $ok = $status && strpos($c, "strong") !== FALSE && preg_match("/\bp\b/", $c) && preg_match("/\ba\b/", $c);
  print (($ok) ? "PASS" : "FAIL") . " status=" . var_export($status, TRUE) . " config=" . ($cfg["settings"]["config"] ?? "none") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
