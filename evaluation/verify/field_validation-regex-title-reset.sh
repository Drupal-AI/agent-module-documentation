#!/usr/bin/env bash
# Execution RESET: clear ALL field_validation_rule_set config entities so the agent starts
# from empty state (the site ships none). Independent runs. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("field_validation_rule_set")->loadMultiple() as $s) { $s->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: all field_validation_rule_set entities deleted"
