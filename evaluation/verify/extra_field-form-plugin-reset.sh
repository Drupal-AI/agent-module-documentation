#!/usr/bin/env bash
# Execution RESET for "write an ExtraFieldForm plugin": uninstall + delete any
# extra_field_eval_form module and drop extra_field_efeval_note from the Article default form
# display, so verify FAILS on empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:uninstall extra_field_eval_form -y >/dev/null 2>&1
rm -rf web/modules/custom/extra_field_eval_form
drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  if ($fd) {
    $fd->removeComponent("extra_field_efeval_note");
    $hidden = $fd->get("hidden") ?: [];
    unset($hidden["extra_field_efeval_note"]);
    $fd->set("hidden", $hidden)->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: extra_field_eval_form removed, extra_field_efeval_note unplaced"
