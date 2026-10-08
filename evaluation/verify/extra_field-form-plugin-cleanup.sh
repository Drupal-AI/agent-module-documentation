#!/usr/bin/env bash
# Execution CLEANUP: uninstall and delete extra_field_eval_form and unplace its pseudo-field.
# Idempotent. Exit 0.
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
echo "cleanup: extra_field_eval_form removed"
