#!/usr/bin/env bash
# Execution VERIFY for "add the Templates button to the ckeditor_templates_eval format and
# make 'Replace actual contents' ticked by default".
# PASS when editor.editor.ckeditor_templates_eval has 'ckeditorTemplates' in
# settings.toolbar.items and settings.plugins.ckeditor_templates_plugin.replace_content === TRUE.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $e = \Drupal\editor\Entity\Editor::load("ckeditor_templates_eval");
  $s = $e ? $e->getSettings() : [];
  $items = $s["toolbar"]["items"] ?? [];
  $button = in_array("ckeditorTemplates", $items, TRUE);
  $replace = $s["plugins"]["ckeditor_templates_plugin"]["replace_content"] ?? NULL;
  $ok = $button && ($replace === TRUE || $replace === 1);
  print ($ok ? "PASS" : "FAIL")
    . " toolbar_button=" . var_export($button, TRUE)
    . " replace_content=" . var_export($replace, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
