#!/usr/bin/env bash
# Execution RESET for "enable the Administration language interface method": remove the
# administration-language-negotiation key from language.types interface enabled methods, so
# verify FAILS until the agent enables it. Leaves other enabled methods intact. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("language.types");
  $en = $c->get("negotiation.language_interface.enabled") ?: [];
  unset($en["administration-language-negotiation"]);
  $c->set("negotiation.language_interface.enabled", $en)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: administration-language-negotiation disabled for interface language type"
