#!/usr/bin/env bash
# Execution VERIFY: PASS when md_switch's Markdown filter is enabled AND its configured parser
# (settings.id) is 'parsedown'. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  $f = FilterFormat::load("md_switch");
  $id = "none";
  $ok = FALSE;
  if ($f) {
    $filters = $f->get("filters");
    $id = $filters["markdown"]["settings"]["id"] ?? "unset";
    $ok = !empty($filters["markdown"]["status"]) && ($id === "parsedown");
  }
  print ($ok ? "PASS" : "FAIL") . " parser=" . $id . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
