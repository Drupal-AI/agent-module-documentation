#!/usr/bin/env bash
# Introspection CLEANUP: uninstall extra_field_example and drop the hidden marker it left on
# the user form display. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $ud = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("user.user.default");
  if ($ud) {
    $h = $ud->get("hidden") ?: [];
    unset($h["extra_field_example_custom_input"]);
    $ud->set("hidden", $h)->save();
  }
' >/dev/null 2>&1
drush pm:uninstall extra_field_example -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: extra_field_example uninstalled"
