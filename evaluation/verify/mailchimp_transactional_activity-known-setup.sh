#!/usr/bin/env bash
# Introspection SETUP: create two Activity config entities — mta_user (user/user/mail, ENABLED)
# and mta_off (node/article/field_email, DISABLED) — so an inspecting agent can read the mapping
# and enabled state back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("mailchimp_transactional_activity");
  if (!$s->load("mta_user")) {
    $s->create(["id"=>"mta_user","label"=>"User email activity","entity_type"=>"user","bundle"=>"user","entity_path"=>"user","email_property"=>"mail","enabled"=>TRUE])->save();
  }
  if (!$s->load("mta_off")) {
    $s->create(["id"=>"mta_off","label"=>"Article email activity","entity_type"=>"node","bundle"=>"article","entity_path"=>"node","email_property"=>"field_email","enabled"=>FALSE])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: mta_user (user/mail, enabled) and mta_off (node/article/field_email, disabled)"
