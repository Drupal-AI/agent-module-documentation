#!/usr/bin/env bash
# Execution RESET: force bootstrap_library back to the shipped path settings
# (url.visibility "0" = everywhere except the listed admin-ish paths), so verify FAILS until
# the agent restricts loading to /bl-eval-landing. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("bootstrap_library.settings")
    ->set("url.visibility", "0")
    ->set("url.pages", ["admin*","imagebrowser*","img_assist*","imce*","node/add/*","node/*/edit","print/*","printpdf/*","system/ajax","system/ajax/*"])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: bootstrap_library url settings back to install defaults"
