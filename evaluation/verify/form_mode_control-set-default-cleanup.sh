#!/usr/bin/env bash
# Execution CLEANUP: remove the fmc_task form display + form mode and empty defaults. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $etm = \Drupal::entityTypeManager();
  if ($fd = $etm->getStorage("entity_form_display")->load("node.article.fmc_task")) { $fd->delete(); }
  if ($fm = $etm->getStorage("entity_form_mode")->load("node.fmc_task")) { $fm->delete(); }
  \Drupal::configFactory()->getEditable("form_mode_control.settings")->set("defaults", [])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: fmc_task form mode/display removed; defaults emptied"
