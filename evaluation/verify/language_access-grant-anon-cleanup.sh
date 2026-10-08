#!/usr/bin/env bash
# hard CLEANUP (language_access): remove 'access language fy' from anonymous and delete language fy. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\language\Entity\ConfigurableLanguage;
  $c = \Drupal::configFactory()->getEditable("user.role.anonymous");
  $perms = array_values(array_diff($c->get("permissions") ?: [], ["access language fy"]));
  $c->set("permissions", $perms)->save();
  if ($l = ConfigurableLanguage::load("fy")) { $l->delete(); }
' >/dev/null 2>&1
echo "cleanup: anonymous 'access language fy' removed; language fy removed"
