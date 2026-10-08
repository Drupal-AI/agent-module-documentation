#!/usr/bin/env bash
# Execution CLEANUP: remove wa_wf workflow and its workflow_access.role grants.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $cf = \Drupal::configFactory();
  $cf->getEditable("workflow_access.role")->clear("wa_wf_published")->clear("wa_wf_review")->save();
  foreach ($cf->listAll("") as $n) { if (strpos($n, "wa_wf") !== FALSE) $cf->getEditable($n)->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: wa_wf workflow + grants removed"
