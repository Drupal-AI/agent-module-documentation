#!/usr/bin/env bash
# Execution VERIFY for "add the Div Manager button to the cdm_task CKEditor 5 toolbar".
# PASS when editor.editor.cdm_task settings.toolbar.items contains 'DivManager'.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\editor\Entity\Editor;
  $e = Editor::load("cdm_task");
  $items = $e ? ($e->getSettings()["toolbar"]["items"] ?? []) : [];
  $ok = in_array("DivManager", $items, TRUE);
  print ($ok ? "PASS" : "FAIL") . " toolbar=" . json_encode($items) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
