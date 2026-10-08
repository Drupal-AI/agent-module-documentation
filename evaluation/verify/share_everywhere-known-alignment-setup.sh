#!/usr/bin/env bash
# Introspection SETUP: set alignment=right and disable the WhatsApp button. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '$c=\Drupal::configFactory()->getEditable("share_everywhere.settings"); $c->set("alignment","right")->set("buttons.whatsapp.enabled",0)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: share_everywhere.settings alignment=right whatsapp disabled"
