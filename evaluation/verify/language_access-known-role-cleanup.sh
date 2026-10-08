#!/usr/bin/env bash
# medium CLEANUP (language_access): remove role langaccess_reviewer and language is. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\language\Entity\ConfigurableLanguage;
  \Drupal::configFactory()->getEditable("user.role.langaccess_reviewer")->delete();
  if ($l = ConfigurableLanguage::load("is")) { $l->delete(); }
' >/dev/null 2>&1
echo "cleanup: langaccess_reviewer and language is removed"
