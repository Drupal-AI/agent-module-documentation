#!/usr/bin/env bash
# Reset the field_group "view display tabs" execution baseline between eval runs so each
# condition is independent: remove the `group_eval_vtabs` (tabs container) and
# `group_eval_vtab` (tab) field groups from the node.article.default entity_view_display
# third_party_settings.field_group (leaving the fields themselves intact), then rebuild
# caches. No arguments.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $d = \Drupal::service("entity_display.repository")->getViewDisplay("node", "article", "default");
  $changed = FALSE;
  foreach (["group_eval_vtabs", "group_eval_vtab"] as $g) {
    if ($d && $d->getThirdPartySetting("field_group", $g) !== NULL) {
      $d->unsetThirdPartySetting("field_group", $g);
      $changed = TRUE;
    }
  }
  if ($changed) { $d->save(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_group group_eval_vtabs/group_eval_vtab removed from node.article.default view display"
