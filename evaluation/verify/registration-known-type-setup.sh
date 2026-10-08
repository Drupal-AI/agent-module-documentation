#!/usr/bin/env bash
# Introspection SETUP: create a known registration_type so an agent can read its hold-expiration.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\registration\Entity\RegistrationType;
  $t = RegistrationType::load("reg_known") ?: RegistrationType::create(["id" => "reg_known"]);
  $t->set("label", "Reg Known")
    ->set("workflow", "registration")
    ->set("defaultState", "pending")
    ->set("heldExpireTime", 72)
    ->set("heldExpireState", "canceled")
    ->save();
' >/dev/null 2>&1
echo "setup: registration.type.reg_known heldExpireTime=72 defaultState=pending"
