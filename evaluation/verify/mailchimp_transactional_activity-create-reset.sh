#!/usr/bin/env bash
# Execution RESET: remove any Activity mapping that targets the User entity's mail property, so
# verify FAILS until the agent creates one. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("mailchimp_transactional_activity");
  foreach ($s->loadMultiple() as $e) {
    if (($e->entity_type ?? "") === "user" && ($e->email_property ?? "") === "mail") { $e->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: no Activity mapping for user/mail"
