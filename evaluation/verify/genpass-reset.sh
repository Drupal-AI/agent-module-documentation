#!/usr/bin/env bash
# Reset genpass.settings to install defaults so each execution case starts from a known
# baseline and its verify FAILS on empty/default state. Defaults:
#   genpass_length=12 genpass_mode=2 genpass_admin_mode=1 genpass_display=0
#   genpass_override_core=true
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("genpass.settings")
    ->set("genpass_length", 12)
    ->set("genpass_mode", 2)
    ->set("genpass_admin_mode", 1)
    ->set("genpass_display", 0)
    ->set("genpass_override_core", TRUE)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: genpass.settings restored to install defaults"
