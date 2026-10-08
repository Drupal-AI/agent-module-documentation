#!/usr/bin/env bash
# Introspection CLEANUP: restore the shipped bootstrap_library path defaults
# (config/install/bootstrap_library.settings.yml). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("bootstrap_library.settings")
    ->set("url.visibility", "0")
    ->set("url.pages", ["admin*","imagebrowser*","img_assist*","imce*","node/add/*","node/*/edit","print/*","printpdf/*","system/ajax","system/ajax/*"])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: bootstrap_library url settings restored to install defaults"
