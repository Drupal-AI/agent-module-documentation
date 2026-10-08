#!/usr/bin/env bash
# Execution CLEANUP: identical to the reset - uninstall and delete extra_field_eval_display
# and unplace its pseudo-field. Idempotent. Exit 0.
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
echo "cleanup: extra_field_eval_display removed"
