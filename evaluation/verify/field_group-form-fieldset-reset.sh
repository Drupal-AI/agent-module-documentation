#!/usr/bin/env bash
# Reset the field_group "form fieldset" execution baseline between eval runs so each
# condition is independent: remove the `group_eval_fieldset` field group from the
# node.article.default entity_form_display third_party_settings.field_group (leaving the
# fields themselves intact), then rebuild caches. No arguments.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $d = \Drupal::service("entity_display.repository")->getFormDisplay("node", "article", "default");
  if ($d && $d->getThirdPartySetting("field_group", "group_eval_fieldset") !== NULL) {
    $d->unsetThirdPartySetting("field_group", "group_eval_fieldset");
    $d->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_group group_eval_fieldset removed from node.article.default form display"
