#!/usr/bin/env bash
# Introspection CLEANUP: delete the eval consent agreement. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("gdpr_consent_agreement");
  foreach ($s->loadByProperties(["title" => "GDPR Eval Consent"]) as $e) { $e->delete(); }
' >/dev/null 2>&1
echo "cleanup: GDPR Eval Consent agreement removed"
