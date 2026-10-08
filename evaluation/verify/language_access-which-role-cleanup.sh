#!/usr/bin/env bash
# medium CLEANUP (language_access): remove langaccess_alpha, langaccess_beta and language nb. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\language\Entity\ConfigurableLanguage;
  \Drupal::configFactory()->getEditable("user.role.langaccess_alpha")->delete();
  \Drupal::configFactory()->getEditable("user.role.langaccess_beta")->delete();
  if ($l = ConfigurableLanguage::load("nb")) { $l->delete(); }
' >/dev/null 2>&1
echo "cleanup: langaccess_alpha, langaccess_beta and language nb removed"
