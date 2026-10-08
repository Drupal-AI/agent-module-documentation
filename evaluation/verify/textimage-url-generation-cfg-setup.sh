#!/usr/bin/env bash
# Introspection SETUP: enable direct URL generation and set a known text separator, so an
# inspecting agent can read url_generation from textimage.settings. Baseline: disabled, '---'.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("textimage.settings");
  $c->set("url_generation.enabled", TRUE)->set("url_generation.text_separator", "###")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: textimage.settings url_generation.enabled=true text_separator=###"
