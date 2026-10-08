#!/usr/bin/env bash
# Introspection CLEANUP: the matching setup only guaranteed the baseline (emulsify_twig
# installed), so there is nothing to undo — this just re-asserts it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  print "emulsify_twig=" . (\Drupal::moduleHandler()->moduleExists("emulsify_twig") ? "enabled" : "disabled") . "\n";
' 2>/dev/null
echo "cleanup: baseline (emulsify_twig enabled)"
exit 0
