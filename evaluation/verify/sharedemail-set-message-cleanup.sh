#!/usr/bin/env bash
# Execution CLEANUP: restore the shipped default warning message. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("sharedemail.settings")
    ->set("sharedemail_msg", "The e-mail address you are using, has already been registered on this site by another user. You should be aware that personal information such as password resets will be sent to this address. We strongly recommend changing your registered address to a different e-mail address. You can do this at any time from your account page when you login.")->save();
' >/dev/null 2>&1
echo "cleanup: sharedemail_msg restored to shipped default"
