#!/usr/bin/env bash
# Introspection CLEANUP: delete the wf_known workflow and its states/transitions. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $cf = \Drupal::configFactory();
  foreach ($cf->listAll("") as $n) { if (strpos($n, "wf_known") !== FALSE) $cf->getEditable($n)->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: workflow wf_known removed"
