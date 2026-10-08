#!/usr/bin/env bash
# Introspection SETUP: add a custom 'Justify' title position option (class section-justify-title)
# so an inspecting agent can read the configured positions. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("layout_builder_sections_config.settings");
  $c->set("title_positions", "section-left-title|Left\r\nsection-center-title|Center\r\nsection-right-title|Right\r\nsection-justify-title|Justify")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: title_positions includes section-justify-title|Justify"
