#!/usr/bin/env bash
# Execution CLEANUP: delete the wf_trans workflow and its states/transitions. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '$cf=\Drupal::configFactory(); foreach ($cf->listAll("") as $n) { if (strpos($n,"wf_trans")!==FALSE) $cf->getEditable($n)->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: workflow wf_trans removed"
