#!/usr/bin/env bash
# Execution VERIFY: PASS when rv_num 'nid' field uses field_export handler AND the number_export
# formatter (type number_export).
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\views\Entity\View;
  $v = View::load("rv_num");
  $f = $v ? ($v->getDisplay("default")["display_options"]["fields"]["nid"] ?? []) : [];
  $ok = (($f["plugin_id"] ?? "") === "field_export") && (($f["type"] ?? "") === "number_export");
  print ($ok ? "PASS" : "FAIL") . " plugin_id=" . ($f["plugin_id"] ?? "none") . " type=" . ($f["type"] ?? "none") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
