#!/usr/bin/env bash
# Execution RESET: ensure typed_entity_example is enabled (so the bundle-less 'user' repository
# exists) and delete any leftover probe user (by email), so verify FAILS until the agent creates
# it. NB: this site's email_registration module forces the username to equal the email, so the
# email is the stable identifier. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en typed_entity_example -y >/dev/null 2>&1
drush php:eval '
  foreach(\Drupal\user\Entity\User::loadMultiple(\Drupal::entityQuery("user")->accessCheck(FALSE)->condition("mail","te_probe_user@example.com")->execute()) as $u){$u->delete();}
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: typed_entity_example enabled; no user with mail te_probe_user@example.com"
