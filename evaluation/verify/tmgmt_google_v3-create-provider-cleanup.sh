#!/usr/bin/env bash
# Execution CLEANUP: delete the tmgmtg_task translator the agent created. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\tmgmt\Entity\Translator;
  if ($t = Translator::load("tmgmtg_task")) { $t->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: tmgmt.translator.tmgmtg_task removed"
