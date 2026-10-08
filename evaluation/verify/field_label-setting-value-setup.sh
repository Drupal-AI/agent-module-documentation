#!/usr/bin/env bash
# Introspection SETUP: set a known field_label.settings class_list and enable the class select
# so an inspecting agent can read the value back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("field_label.settings");
  $c->set("label_class_select_enabled", TRUE);
  $c->set("class_list", ".fl-primary|Primary label");
  $c->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_label.settings.class_list='.fl-primary|Primary label', label_class_select_enabled=TRUE"
