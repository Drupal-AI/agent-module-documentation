#!/usr/bin/env bash
# Introspection CLEANUP: restore field_label.settings shipped defaults for the two keys the
# setup touched. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("field_label.settings");
  $c->set("label_class_select_enabled", FALSE);
  $c->set("class_list", "");
  $c->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_label.settings restored (class_list='', label_class_select_enabled=FALSE)"
