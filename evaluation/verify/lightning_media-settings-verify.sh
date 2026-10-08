#!/usr/bin/env bash
# Execution VERIFY: PASS when lightning_media.settings has revision_ui TRUE and
# entity_embed.choose_display TRUE, AND the live media entity type definition reflects the
# revision UI flag (show_revision_ui TRUE) - i.e. cached definitions were cleared too.
# exit 0 = pass, 1 = fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("lightning_media.settings");
  $revision = (bool) $c->get("revision_ui");
  $choose = (bool) $c->get("entity_embed.choose_display");
  $definition = \Drupal::entityTypeManager()->getDefinition("media");
  $show = (bool) $definition->get("show_revision_ui");
  $ok = ($revision && $choose && $show);
  print ($ok ? "PASS" : "FAIL")
    . " revision_ui=" . var_export($revision, TRUE)
    . " choose_display=" . var_export($choose, TRUE)
    . " media.show_revision_ui=" . var_export($show, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
