#!/usr/bin/env bash
# Execution RESET: (re)create a DISABLED Activity mapping mta_toggle (user/mail), so verify FAILS
# until the agent enables it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("mailchimp_transactional_activity");
  if ($e = $s->load("mta_toggle")) { $e->delete(); }
  $s->create(["id"=>"mta_toggle","label"=>"Toggle activity","entity_type"=>"user","bundle"=>"user","entity_path"=>"user","email_property"=>"mail","enabled"=>FALSE])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: mta_toggle created, enabled=false"
