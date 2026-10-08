#!/usr/bin/env bash
# Introspection SETUP: create a gdpr_consent_agreement (title 'GDPR Eval Consent', explicit)
# so an inspecting agent can read its mode/title from the live site. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("gdpr_consent_agreement");
  foreach ($s->loadByProperties(["title" => "GDPR Eval Consent"]) as $e) { $e->delete(); }
  $s->create(["title" => "GDPR Eval Consent", "mode" => "explicit", "description" => "Eval agreement."])->save();
' >/dev/null 2>&1
echo "setup: gdpr_consent_agreement title='GDPR Eval Consent' mode=explicit"
