#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\views\Entity\View;
  $v = View::load("rvr_task");
  $f = $v ? ($v->getDisplay("default")["display_options"]["fields"]["nid"] ?? []) : [];
  $ok = (($f["plugin_id"] ?? "") === "field_export") && (($f["type"] ?? "") === "entity_reference_revisions_export");
  print ($ok ? "PASS" : "FAIL") . " plugin_id=" . ($f["plugin_id"] ?? "none") . " type=" . ($f["type"] ?? "none") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
