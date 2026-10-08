#!/usr/bin/env bash
# medium SETUP (language_access): add Icelandic (is) and a custom role langaccess_reviewer
# granted 'access language is'. The role is written as user.role.* config (identical to what
# Role::save() produces). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\language\Entity\ConfigurableLanguage;
  if (!ConfigurableLanguage::load("is")) { ConfigurableLanguage::createFromLangcode("is")->save(); }
  \Drupal::configFactory()->getEditable("user.role.langaccess_reviewer")->setData([
    "uuid" => \Drupal::service("uuid")->generate(), "langcode" => "en", "status" => TRUE,
    "dependencies" => [], "id" => "langaccess_reviewer", "label" => "Language Access Reviewer",
    "weight" => 10, "is_admin" => FALSE, "permissions" => ["access language is"],
  ])->save();
' >/dev/null 2>&1
echo "setup: language is added; role langaccess_reviewer granted 'access language is'"
