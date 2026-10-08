#!/usr/bin/env bash
# Restore layout_builder_sections_config.settings to shipped defaults (wrapper/position/colour
# option lists). Used as CLEANUP and RESET. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '$c = \Drupal::configFactory()->getEditable("layout_builder_sections_config.settings");
$c->set("title_wrappers", "h1|H1\r\nh2|H2\r\nh3|H3\r\nh4|H4\r\nh5|H5\r\nh6|H6")
  ->set("title_positions", "section-left-title|Left\r\nsection-center-title|Center\r\nsection-right-title|Right")
  ->set("title_colors", "section-black-title|Black\r\nsection-white-title|White\r\nsection-blue-title|Blue")
  ->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "baseline: layout_builder_sections_config.settings restored to shipped option lists"
