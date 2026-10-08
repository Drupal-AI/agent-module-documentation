#!/usr/bin/env bash
# Introspection SETUP: create a role and write a known CAS Attributes configuration (one role
# mapping plus field mappings and sync frequencies) so an agent can read it back off the live
# site. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if (!Role::load("cas_attributes_known")) {
    Role::create(["id" => "cas_attributes_known", "label" => "CAS Attributes Known"])->save();
  }
  \Drupal::configFactory()->getEditable("cas_attributes.settings")
    ->set("field.sync_frequency", 2)
    ->set("field.overwrite", TRUE)
    ->set("field.mappings", ["mail" => "[cas:attribute:workemail]"])
    ->set("role.sync_frequency", 2)
    ->set("role.deny_login_no_match", FALSE)
    ->set("role.deny_registration_no_match", FALSE)
    ->set("role.mappings", [[
      "rid" => "cas_attributes_known",
      "attribute" => "eduPersonAffiliation",
      "value" => "librarian",
      "method" => "exact_any",
      "negate" => FALSE,
      "remove_without_match" => TRUE,
    ]])
    ->save();
' >/dev/null 2>&1
echo "setup: cas_attributes.settings has one role mapping (eduPersonAffiliation=librarian -> cas_attributes_known)"
