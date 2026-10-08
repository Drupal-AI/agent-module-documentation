#!/usr/bin/env bash
# Helper (sourced): safe_remove <module_machine_name>
# Uninstalls a module and only THEN deletes web/modules/custom/<module>. Deleting the files of
# a module that is still listed in core.extension makes the whole Drupal site fail to
# bootstrap, so the directory is left in place if the uninstall did not take.
# Always returns 0.
safe_remove() {
  local m="$1"
  drush pm:uninstall "$m" -y >/dev/null 2>&1
  drush cr >/dev/null 2>&1
  local still
  still=$(drush php:eval "print isset(\Drupal::config('core.extension')->get('module')['$m']) ? 'YES' : 'NO';" 2>/dev/null | tr -d '[:space:]')
  if [ "$still" = "NO" ]; then
    rm -rf "web/modules/custom/$m"
  else
    echo "WARNING: $m still installed - leaving web/modules/custom/$m in place"
  fi
  return 0
}
