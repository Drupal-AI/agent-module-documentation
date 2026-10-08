#!/usr/bin/env bash
# Introspection CLEANUP: remove the known `eval_intro_set` field_validation_rule_set,
# restoring baseline (it does not ship by default). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field_validation\Entity\FieldValidationRuleSet;
  if ($e = FieldValidationRuleSet::load("eval_intro_set")) { $e->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_validation_rule_set eval_intro_set removed"
