#!/usr/bin/env bash
# Introspection SETUP: disable ONLY the data-* attribute for sections (leave other section
# attributes enabled), so an inspecting agent can read that data-* is not allowed. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("layout_custom_section_classes.settings");
  $c->set("allowed_section_attributes", ["id" => TRUE, "class_list" => TRUE, "class" => TRUE, "style" => TRUE, "data" => FALSE])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: layout_custom_section_classes.settings allowed_section_attributes.data = false"
