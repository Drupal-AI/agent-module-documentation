#!/usr/bin/env bash
# Execution RESET for "write an ExtraFieldDisplay plugin": uninstall + delete any
# extra_field_eval_display module the agent may have created, and drop the
# extra_field_efeval_greeting component from the Article default view display, so verify
# FAILS on empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:uninstall extra_field_eval_display -y >/dev/null 2>&1
rm -rf web/modules/custom/extra_field_eval_display
drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  if ($vd) {
    $vd->removeComponent("extra_field_efeval_greeting");
    $hidden = $vd->get("hidden") ?: [];
    unset($hidden["extra_field_efeval_greeting"]);
    $vd->set("hidden", $hidden)->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: extra_field_eval_display removed, extra_field_efeval_greeting unplaced"
