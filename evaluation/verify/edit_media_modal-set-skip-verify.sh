#!/usr/bin/env bash
# Execution VERIFY: PASS when the emm_probe editor's Edit Media Modal skipAccessCheck is truthy
# (TRUE / 1). exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("editor.editor.emm_probe")->get("settings.plugins.media_edit_media_modal.editMediaModal.extras.skipAccessCheck");
  $ok = ($v === TRUE || $v === 1 || $v === "1");
  print ($ok ? "PASS" : "FAIL") . " skipAccessCheck=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
