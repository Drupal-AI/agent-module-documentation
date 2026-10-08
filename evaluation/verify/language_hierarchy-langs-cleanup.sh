#!/usr/bin/env bash
# Shared CLEANUP: delete the eval languages lhc, lhm, lhp (order: children first). Deleting a
# language rebuilds the language_hierarchy_priority table. Leaves the site clean. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\language\Entity\ConfigurableLanguage;
  foreach (["lhc", "lhm", "lhp"] as $lc) { if ($l = ConfigurableLanguage::load($lc)) { $l->delete(); } }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: languages lhc, lhm, lhp removed"
