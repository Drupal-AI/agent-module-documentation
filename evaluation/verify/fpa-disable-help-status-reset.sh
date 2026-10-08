#!/usr/bin/env bash
# Execution RESET: clear fpa.settings back to the install default (disabled_sections = {},
# every section visible) so the "disable page help text + permission status filter" task
# starts from empty and verify FAILs until the agent does the work. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("fpa.settings")
    ->set("disabled_sections", [])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: fpa.settings disabled_sections = {} (baseline)"
