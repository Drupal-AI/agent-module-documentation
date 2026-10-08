#!/usr/bin/env bash
# Introspection CLEANUP: delete the cdm_on / cdm_off text formats and their editors.
# Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  foreach (["cdm_on", "cdm_off"] as $id) {
    if ($e = Editor::load($id)) { $e->delete(); }
    if ($f = FilterFormat::load($id)) { $f->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: cdm_on and cdm_off removed"
