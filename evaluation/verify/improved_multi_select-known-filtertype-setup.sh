#!/usr/bin/env bash
# Introspection SETUP: set a known filtertype + placeholder on improved_multi_select.settings
# so an inspecting agent can read them back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("improved_multi_select.settings");
  $c->set("filtertype", "allwords_partial")->set("placeholder_text", "ims_find_here")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: improved_multi_select.settings filtertype=allwords_partial placeholder_text=ims_find_here"
