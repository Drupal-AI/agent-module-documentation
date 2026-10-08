#!/usr/bin/env bash
# Execution VERIFY for "enable the file_rename rename link on the field_fr_task widget".
# PASS when field_fr_task's component in core.entity_form_display.node.article.default carries
# third_party_settings.file_rename.show_rename_link === TRUE. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $c = $fd ? $fd->getComponent("field_fr_task") : NULL;
  $show = $c["third_party_settings"]["file_rename"]["show_rename_link"] ?? NULL;
  $ok = ($show === TRUE);
  print ($ok ? "PASS" : "FAIL") . " widget=" . ($c["type"] ?? "none") . " show_rename_link=" . var_export($show, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
