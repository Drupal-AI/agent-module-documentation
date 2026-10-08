#!/usr/bin/env bash
# Introspection cleanup: restore baseline after the medium cases by removing the two known
# eval section_library_template entities. Idempotent — a no-op if they do not exist.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("section_library_template");
  foreach (["Eval Landing Page", "Eval Promo Section"] as $lbl) {
    $ids = $storage->getQuery()->accessCheck(FALSE)->condition("label", $lbl)->execute();
    if ($ids) { $storage->delete($storage->loadMultiple($ids)); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: eval section_library_template entities removed"
