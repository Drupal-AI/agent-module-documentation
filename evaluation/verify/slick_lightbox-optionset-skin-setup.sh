#!/usr/bin/env bash
# Introspection SETUP: set a known skin ('boxy') on the slick_lightbox Slick optionset so an
# inspecting agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("slick.optionset.slick_lightbox")->set("skin", "boxy")->save();' >/dev/null 2>&1
echo "setup: slick.optionset.slick_lightbox skin=boxy"
