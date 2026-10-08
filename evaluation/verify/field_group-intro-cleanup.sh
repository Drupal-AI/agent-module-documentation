#!/usr/bin/env bash
# Introspection CLEANUP: remove the known group_eval_publish field group from the
# node.article.default entity_form_display, restoring baseline. Idempotent: no-op if
# already gone. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $d = \Drupal::service("entity_display.repository")->getFormDisplay("node", "article", "default");
  if ($d && $d->getThirdPartySetting("field_group", "group_eval_publish") !== NULL) {
    $d->unsetThirdPartySetting("field_group", "group_eval_publish");
    $d->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_group group_eval_publish removed from node.article.default form display"
