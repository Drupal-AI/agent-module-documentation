#!/usr/bin/env bash
# Execution RESET: remove any Template Map with mailsystem_key 'default-system', so verify FAILS
# until the agent creates one. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("mailchimp_transactional_template");
  foreach ($s->loadMultiple() as $e) { if (($e->mailsystem_key ?? "") === "default-system") { $e->delete(); } }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: no default-system Template Map"
