#!/usr/bin/env bash
# Execution VERIFY (H2): PASS when the dashboard_last_content view is enabled.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
$v=\Drupal\views\Entity\View::load("dashboard_last_content");
print (($v && $v->status()) ? "PASS" : "FAIL")."\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q "^PASS" && exit 0 || exit 1
