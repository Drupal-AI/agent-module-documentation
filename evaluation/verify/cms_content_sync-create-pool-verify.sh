#!/usr/bin/env bash
# Execution VERIFY: PASS when a cms_content_sync Pool 'ccs_task_pool' exists with the
# requested backend_url. (In 3.2.x the Pool config entity only exports id/label/backend_url.)
# Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\cms_content_sync\Entity\Pool;
  $p = Pool::load("ccs_task_pool");
  $url = $p ? $p->backend_url : NULL;
  $ok = ($p && $url === "https://task.content-sync.example");
  print ($ok ? "PASS" : "FAIL") . " backend_url=" . var_export($url, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
