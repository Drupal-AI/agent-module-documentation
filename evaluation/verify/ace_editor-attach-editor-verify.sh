#!/usr/bin/env bash
# Execution VERIFY: PASS when editor.editor.ace_editor_h1 uses the Ace editor plugin with
# fieldset.theme=twilight and fieldset.syntax=javascript. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\editor\Entity\Editor;
  $e = Editor::load("ace_editor_h1");
  $ed = $e ? $e->getEditor() : NULL;
  $s = $e ? $e->getSettings() : [];
  $theme = $s["fieldset"]["theme"] ?? NULL;
  $syntax = $s["fieldset"]["syntax"] ?? NULL;
  $ok = ($ed === "ace_editor" && $theme === "twilight" && $syntax === "javascript");
  print ($ok ? "PASS" : "FAIL") . " editor=" . var_export($ed, TRUE) . " theme=" . var_export($theme, TRUE) . " syntax=" . var_export($syntax, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
