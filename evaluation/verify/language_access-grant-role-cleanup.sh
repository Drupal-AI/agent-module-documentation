#!/usr/bin/env bash
# hard CLEANUP (language_access): remove role langaccess_task and language fo. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\language\Entity\ConfigurableLanguage;
  \Drupal::configFactory()->getEditable("user.role.langaccess_task")->delete();
  if ($l = ConfigurableLanguage::load("fo")) { $l->delete(); }
' >/dev/null 2>&1
echo "cleanup: langaccess_task and language fo removed"
