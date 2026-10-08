#!/usr/bin/env bash
# Execution CLEANUP: disable the administration-language-negotiation method again (restore
# baseline: not enabled for the interface language type). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("language.types");
  $en = $c->get("negotiation.language_interface.enabled") ?: [];
  unset($en["administration-language-negotiation"]);
  $c->set("negotiation.language_interface.enabled", $en)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: administration-language-negotiation disabled (baseline restored)"
