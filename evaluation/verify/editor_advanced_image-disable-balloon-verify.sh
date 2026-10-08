#!/usr/bin/env bash
# Execution VERIFY: PASS when editor.editor.eai_dbtask Editor Advanced Image config has
# disable_balloon === TRUE. Prints PASS/FAIL. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\editor\Entity\Editor;
  $e = Editor::load("eai_dbtask");
  $p = $e ? ($e->getSettings()["plugins"]["editor_advanced_image_image"] ?? NULL) : NULL;
  $db = $p["disable_balloon"] ?? NULL;
  $ok = ($db === TRUE);
  print ($ok ? "PASS" : "FAIL") . " disable_balloon=" . var_export($db, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
