#!/usr/bin/env bash
# Execution RESET: reg_conf exists with confirmation DISABLED.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\registration\Entity\RegistrationType;
  $t = RegistrationType::load("reg_conf") ?: RegistrationType::create(["id"=>"reg_conf"]);
  $t->set("label","Reg Conf")->set("workflow","registration")->set("defaultState","pending")->set("heldExpireState","canceled");
  $t->setThirdPartySetting("registration_confirmation","enable",FALSE);
  $t->save();
' >/dev/null 2>&1
echo "reset: registration.type.reg_conf confirmation enable=FALSE"
