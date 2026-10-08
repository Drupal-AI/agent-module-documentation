#!/usr/bin/env bash
# Execution RESET: enable typed_entity_example and delete any probe user (by email) so verify
# FAILS until one exists (and wraps as User). NB: email_registration forces username=email, so
# the email is the stable identifier. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en typed_entity_example -y >/dev/null 2>&1
drush php:eval '
  foreach(\Drupal\user\Entity\User::loadMultiple(\Drupal::entityQuery("user")->accessCheck(FALSE)->condition("mail","tee_probe_user@example.com")->execute()) as $u){$u->delete();}
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: typed_entity_example enabled; no user with mail tee_probe_user@example.com"
