#!/usr/bin/env bash
# Execution VERIFY: PASS when filter_ckeditor_media_embed is enabled on ckme_hard_format.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  $f = FilterFormat::load("ckme_hard_format");
  $filters = $f ? $f->get("filters") : [];
  $status = $filters["filter_ckeditor_media_embed"]["status"] ?? NULL;
  $ok = ($status === TRUE || $status === 1 || $status === "1");
  print ($ok ? "PASS" : "FAIL") . " status=" . var_export($status, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
