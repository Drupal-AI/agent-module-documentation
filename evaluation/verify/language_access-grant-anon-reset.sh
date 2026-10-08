#!/usr/bin/env bash
# hard RESET (language_access): add Western Frisian (fy) and ensure the anonymous role does NOT
# grant 'access language fy' so verify FAILS until it is granted. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\language\Entity\ConfigurableLanguage;
  if (!ConfigurableLanguage::load("fy")) { ConfigurableLanguage::createFromLangcode("fy")->save(); }
  $c = \Drupal::configFactory()->getEditable("user.role.anonymous");
  $perms = array_values(array_diff($c->get("permissions") ?: [], ["access language fy"]));
  $c->set("permissions", $perms)->save();
' >/dev/null 2>&1
echo "reset: language fy added; anonymous role does NOT grant 'access language fy'"
