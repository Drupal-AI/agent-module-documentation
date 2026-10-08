#!/usr/bin/env bash
# Execution VERIFY: PASS when the rv_task 'title' field uses the serializable Views handler
# (plugin_id field_export).
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\views\Entity\View;
  $v = View::load("rv_task");
  $f = $v ? ($v->getDisplay("default")["display_options"]["fields"]["title"] ?? []) : [];
  $pid = $f["plugin_id"] ?? "none";
  $ok = ($pid === "field_export");
  print ($ok ? "PASS" : "FAIL") . " title.plugin_id=" . $pid . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
