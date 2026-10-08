#!/usr/bin/env bash
# medium SETUP (language_access): add Norwegian Bokmal (nb); roles langaccess_alpha (no access)
# and langaccess_beta (granted 'access language nb'), written as user.role.* config. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\language\Entity\ConfigurableLanguage;
  if (!ConfigurableLanguage::load("nb")) { ConfigurableLanguage::createFromLangcode("nb")->save(); }
  $u = \Drupal::service("uuid");
  \Drupal::configFactory()->getEditable("user.role.langaccess_alpha")->setData([
    "uuid" => $u->generate(), "langcode" => "en", "status" => TRUE, "dependencies" => [],
    "id" => "langaccess_alpha", "label" => "Language Access Alpha", "weight" => 10,
    "is_admin" => FALSE, "permissions" => [],
  ])->save();
  \Drupal::configFactory()->getEditable("user.role.langaccess_beta")->setData([
    "uuid" => $u->generate(), "langcode" => "en", "status" => TRUE, "dependencies" => [],
    "id" => "langaccess_beta", "label" => "Language Access Beta", "weight" => 10,
    "is_admin" => FALSE, "permissions" => ["access language nb"],
  ])->save();
' >/dev/null 2>&1
echo "setup: language nb added; langaccess_beta granted 'access language nb', langaccess_alpha not"
