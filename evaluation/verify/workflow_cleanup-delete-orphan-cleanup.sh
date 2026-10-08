#!/usr/bin/env bash
# Execution CLEANUP: ensure the orphaned state wc_orphan is gone. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '$cf=\Drupal::configFactory(); $cf->getEditable("workflow.state.wc_orphan")->delete();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: orphaned state wc_orphan removed"
