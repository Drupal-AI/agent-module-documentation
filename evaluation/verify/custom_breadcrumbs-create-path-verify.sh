#!/usr/bin/env bash
# Execution VERIFY: PASS when custom_breadcrumbs entity cb_task exists, is a PATH type (type 2),
# and its pathPattern targets /cb-task. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\custom_breadcrumbs\Entity\CustomBreadcrumbs;
  $e = CustomBreadcrumbs::load("cb_task");
  $type = $e ? (string) $e->get("type") : "";
  $pp = $e ? (string) $e->get("pathPattern") : "";
  $ok = ($e && $type === "2" && strpos($pp, "cb-task") !== FALSE);
  print (($ok) ? "PASS" : "FAIL") . " type=" . $type . " pathPattern=" . $pp . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
