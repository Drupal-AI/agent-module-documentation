#!/usr/bin/env bash
# Execution VERIFY: PASS when Pool ccs_ach_pool (correct backend_url) AND Flow ccs_ach_flow
# (variant simple) both exist. Exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\cms_content_sync\Entity\Pool;
  use Drupal\cms_content_sync\Entity\Flow;
  $p = Pool::load("ccs_ach_pool");
  $f = Flow::load("ccs_ach_flow");
  $url = $p ? $p->backend_url : NULL;
  $variant = $f ? $f->variant : NULL;
  $ok = ($p && $url === "https://acquia-migrated.content-sync.example" && $f && $variant === "simple");
  print ($ok ? "PASS" : "FAIL") . " pool_url=" . var_export($url, TRUE) . " flow_variant=" . var_export($variant, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
