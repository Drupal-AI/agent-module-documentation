#!/usr/bin/env bash
# Execution VERIFY: PASS when custom_breadcrumbs entity cb_task2 exists, is a CONTENT-ENTITY type
# (type 1) targeting node/article. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\custom_breadcrumbs\Entity\CustomBreadcrumbs;
  $e = CustomBreadcrumbs::load("cb_task2");
  $type = $e ? (string) $e->get("type") : "";
  $et = $e ? (string) $e->get("entityType") : "";
  $eb = $e ? (string) $e->get("entityBundle") : "";
  $ok = ($e && $type === "1" && $et === "node" && $eb === "article");
  print (($ok) ? "PASS" : "FAIL") . " type=" . $type . " entityType=" . $et . " entityBundle=" . $eb . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
