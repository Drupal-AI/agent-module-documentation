#!/usr/bin/env bash
# hard RESET (language_access): add Faroese (fo) and role langaccess_task WITHOUT 'access language fo'
# so verify FAILS until the permission is granted. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\language\Entity\ConfigurableLanguage;
  if (!ConfigurableLanguage::load("fo")) { ConfigurableLanguage::createFromLangcode("fo")->save(); }
  \Drupal::configFactory()->getEditable("user.role.langaccess_task")->setData([
    "uuid" => \Drupal::service("uuid")->generate(), "langcode" => "en", "status" => TRUE,
    "dependencies" => [], "id" => "langaccess_task", "label" => "Language Access Task",
    "weight" => 10, "is_admin" => FALSE, "permissions" => [],
  ])->save();
' >/dev/null 2>&1
echo "reset: language fo added; langaccess_task does NOT have 'access language fo'"
