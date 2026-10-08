#!/usr/bin/env bash
# Introspection CLEANUP (popup_field_group): remove group_pfg_modal. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  if ($fd->getThirdPartySetting("field_group", "group_pfg_modal")) { $fd->unsetThirdPartySetting("field_group", "group_pfg_modal"); $fd->save(); }
' >/dev/null 2>&1 || true
echo "cleanup: group_pfg_modal removed"
exit 0
