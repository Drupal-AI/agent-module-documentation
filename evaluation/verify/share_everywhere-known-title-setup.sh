#!/usr/bin/env bash
# Introspection SETUP: set a known Share Everywhere title. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '$c=\Drupal::configFactory()->getEditable("share_everywhere.settings"); $c->set("title","SE_Custom_Heading")->set("display_title",1)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: share_everywhere.settings title=SE_Custom_Heading"
