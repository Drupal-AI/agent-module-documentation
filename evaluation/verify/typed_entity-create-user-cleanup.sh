#!/usr/bin/env bash
# Execution CLEANUP: delete the probe user (by email) and uninstall typed_entity_example. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach(\Drupal\user\Entity\User::loadMultiple(\Drupal::entityQuery("user")->accessCheck(FALSE)->condition("mail","te_probe_user@example.com")->execute()) as $u){$u->delete();}
' >/dev/null 2>&1
drush pmu typed_entity_example -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: probe user deleted; typed_entity_example uninstalled"
