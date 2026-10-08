#!/usr/bin/env bash
# Introspection CLEANUP: remove the wc_wf workflow and its states. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '$cf=\Drupal::configFactory(); foreach ($cf->listAll("") as $n) { if (strpos($n,"wc_wf")!==FALSE) $cf->getEditable($n)->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: workflow wc_wf removed"
