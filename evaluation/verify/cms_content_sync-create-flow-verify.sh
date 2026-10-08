#!/usr/bin/env bash
# Execution VERIFY: PASS when a cms_content_sync Flow 'ccs_task_flow' exists with
# variant=simple. Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\cms_content_sync\Entity\Flow;
  $f = Flow::load("ccs_task_flow");
  $variant = $f ? $f->variant : NULL;
  $ok = ($f && $variant === "simple");
  print ($ok ? "PASS" : "FAIL") . " variant=" . var_export($variant, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
