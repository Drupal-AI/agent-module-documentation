#!/usr/bin/env bash
# Execution RESET: clear fpa.settings back to the install default (disabled_sections = {},
# every section visible) so the "disable module listing + role filter" task starts from
# empty and the verify FAILs until the agent does the work. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("fpa.settings")
    ->set("disabled_sections", [])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: fpa.settings disabled_sections = {} (baseline)"
