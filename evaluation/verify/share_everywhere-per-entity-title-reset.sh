#!/usr/bin/env bash
# Execution RESET/CLEANUP: restore defaults (per_entity off, title 'Share Everywhere') so verify
# FAILS on empty state. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '$c = \Drupal::configFactory()->getEditable("share_everywhere.settings");
  $c->set("alignment", "left")->set("title", "Share Everywhere")->set("display_title", 1)
    ->set("collapsible", 1)->set("per_entity", 0)
    ->set("buttons.whatsapp.enabled", 1)->set("buttons.viber.enabled", 1)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: share_everywhere.settings defaults (per_entity=0, title='Share Everywhere')"
