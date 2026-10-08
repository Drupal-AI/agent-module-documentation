#!/usr/bin/env bash
# Restore shipped default registration_terms_style=0 (Scroll box).
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("legal.settings")->set("registration_terms_style", 0)->save();' >/dev/null 2>&1
echo "baseline: legal.settings registration_terms_style=0"
