#!/usr/bin/env bash
# Introspection SETUP: add a custom 'Brand' title colour option (class section-brand-title) to
# layout_builder_sections_config so an inspecting agent can read the configured colours.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("layout_builder_sections_config.settings");
  $c->set("title_colors", "section-black-title|Black\r\nsection-white-title|White\r\nsection-blue-title|Blue\r\nsection-brand-title|Brand")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: title_colors includes section-brand-title|Brand"
