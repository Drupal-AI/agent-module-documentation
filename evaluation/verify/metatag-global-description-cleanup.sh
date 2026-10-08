#!/usr/bin/env bash
# Introspection CLEANUP: restore the metatag_defaults `global` entity to baseline by removing
# the `description` tag key (the shipped global ships with no description). Never deletes the
# entity. Idempotent: no-op if already absent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $cfg = \Drupal::configFactory()->getEditable("metatag.metatag_defaults.global");
  $tags = $cfg->get("tags") ?: [];
  unset($tags["description"]);
  $cfg->set("tags", $tags)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: metatag global default description removed (baseline restored)"
