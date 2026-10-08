#!/usr/bin/env bash
# Execution RESET for the "create the upgrade_-prefixed d7_user migration" task. Deletes the
# upgrade_d7_user migration config entity if present so the task starts from empty state.
# Leaves any migration group untouched. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\migrate_plus\Entity\Migration;
  if ($m = Migration::load("upgrade_d7_user")) { $m->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: migration upgrade_d7_user cleared"
