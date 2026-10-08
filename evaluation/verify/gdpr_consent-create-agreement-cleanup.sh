#!/usr/bin/env bash
# Execution CLEANUP: delete the 'GDPR Eval Task' consent agreement(s). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("gdpr_consent_agreement");
  foreach ($s->loadByProperties(["title" => "GDPR Eval Task"]) as $e) { $e->delete(); }
' >/dev/null 2>&1
echo "cleanup: GDPR Eval Task agreement(s) removed"
