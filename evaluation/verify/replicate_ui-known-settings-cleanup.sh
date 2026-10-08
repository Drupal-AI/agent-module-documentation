#!/usr/bin/env bash
# Introspection CLEANUP for the replicate_ui "known settings" medium cases.
# Restores baseline (install defaults) of replicate_ui.settings: no entity types enabled
# and edit-access checking off, then rebuilds so the derived replicate routes/tabs go away.
# Idempotent: safe to run when already at baseline.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("replicate_ui.settings")
    ->set("entity_types", [])
    ->set("check_edit_access", FALSE)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: replicate_ui.settings restored to baseline (entity_types=[], check_edit_access=false)"
