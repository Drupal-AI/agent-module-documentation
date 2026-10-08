#!/usr/bin/env bash
# Introspection CLEANUP: restore baseline (delete the State keys the setup wrote). Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::state();
  $s->delete("drd_agent.debug_mode");
  $s->delete("drd_agent.authorised");
' >/dev/null 2>&1
echo "cleanup: drd_agent.debug_mode and drd_agent.authorised State keys removed"
