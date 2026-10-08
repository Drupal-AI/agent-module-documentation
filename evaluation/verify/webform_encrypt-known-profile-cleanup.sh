#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\webform\Entity\Webform;
  use Drupal\encrypt\Entity\EncryptionProfile;
  use Drupal\key\Entity\Key;
  if ($w = Webform::load("we_encrypt_profile")) { $w->delete(); }
  if ($p = EncryptionProfile::load("we_test_profile")) { $p->delete(); }
  if ($k = Key::load("we_test_key")) { $k->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: we_encrypt_profile / we_test_profile / we_test_key removed"
