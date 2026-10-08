#!/usr/bin/env bash
# Introspection CLEANUP: remove wa_wf workflow and its workflow_access.role grants.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $cf = \Drupal::configFactory();
  $r = $cf->getEditable("workflow_access.role");
  $r->clear("wa_wf_review")->clear("wa_wf_draft")->clear("wa_wf_published")->save();
  foreach ($cf->listAll("") as $n) { if (strpos($n, "wa_wf") !== FALSE) $cf->getEditable($n)->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: wa_wf workflow + grants removed"
