#!/usr/bin/env bash
# Execution CLEANUP: remove any default-system Template Map created during the case. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("mailchimp_transactional_template");
  foreach ($s->loadMultiple() as $e) { if (($e->mailsystem_key ?? "") === "default-system") { $e->delete(); } }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: default-system Template Maps removed"
