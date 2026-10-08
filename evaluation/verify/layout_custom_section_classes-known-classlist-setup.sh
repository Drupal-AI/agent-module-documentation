#!/usr/bin/env bash
# Introspection SETUP: put a known predefined class list into the module's global settings so an
# inspecting agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("layout_custom_section_classes.settings");
  $c->set("class_list", ["bg-eval-dark|Dark background", "py-eval-3"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: layout_custom_section_classes.settings class_list = [bg-eval-dark|Dark background, py-eval-3]"
