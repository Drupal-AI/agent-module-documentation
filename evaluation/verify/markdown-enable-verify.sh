#!/usr/bin/env bash
# Execution VERIFY: PASS when a text format md_task exists with the Markdown filter enabled
# (filters.markdown.status truthy). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  $f = FilterFormat::load("md_task");
  $status = "none";
  if ($f) {
    $filters = $f->get("filters");
    $status = isset($filters["markdown"]["status"]) ? var_export((bool) $filters["markdown"]["status"], TRUE) : "absent";
  }
  $ok = ($f && isset($filters["markdown"]) && !empty($filters["markdown"]["status"]));
  print ($ok ? "PASS" : "FAIL") . " markdown_status=" . $status . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
