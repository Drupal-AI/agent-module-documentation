#!/usr/bin/env bash
# Execution VERIFY (insert_media): PASS when field_insert_mtask's media_library_widget component in
# core.entity_form_display.node.article.default has a non-empty third_party_settings.insert_media.view_modes
# that includes the "full" view mode. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $c = $fd ? $fd->getComponent("field_insert_mtask") : NULL;
  $vm = $c["third_party_settings"]["insert_media"]["view_modes"] ?? [];
  $vm = is_array($vm) ? array_filter($vm) : [];
  $ok = (($c["type"] ?? "") === "media_library_widget" && count($vm) > 0 && array_key_exists("full", $vm));
  print ($ok ? "PASS" : "FAIL") . " widget=" . ($c["type"] ?? "none") . " view_modes=" . implode(",", array_keys($vm)) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
