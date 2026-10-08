#!/usr/bin/env bash
# Execution RESET: delete the tmgmtg_task translator if present, so verify FAILS on empty state
# until the agent creates a Google V3 provider. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\tmgmt\Entity\Translator;
  if ($t = Translator::load("tmgmtg_task")) { $t->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: tmgmt.translator.tmgmtg_task deleted"
