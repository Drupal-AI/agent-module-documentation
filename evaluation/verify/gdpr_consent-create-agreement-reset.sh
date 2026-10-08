#!/usr/bin/env bash
# Execution RESET: ensure NO consent agreement titled 'GDPR Eval Task' exists, so verify FAILS
# until the agent creates one. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("gdpr_consent_agreement");
  foreach ($s->loadByProperties(["title" => "GDPR Eval Task"]) as $e) { $e->delete(); }
' >/dev/null 2>&1
echo "reset: no consent agreement titled GDPR Eval Task"
