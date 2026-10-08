#!/usr/bin/env bash
# Introspection SETUP: set a known privacy-policy URL on the TacJS consent dialog so an
# inspecting agent can read it back. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("tacjs.settings")->set("dialog.privacyUrl","/tacjs-probe-privacy")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: tacjs.settings dialog.privacyUrl=/tacjs-probe-privacy"
