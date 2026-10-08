#!/usr/bin/env bash
# Introspection SETUP: registration type reg_conf with confirmation email enabled + known subject.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\registration\Entity\RegistrationType;
  $t = RegistrationType::load("reg_conf") ?: RegistrationType::create(["id"=>"reg_conf"]);
  $t->set("label","Reg Conf")->set("workflow","registration")->set("defaultState","pending")->set("heldExpireState","canceled");
  $t->setThirdPartySetting("registration_confirmation","enable",TRUE);
  $t->setThirdPartySetting("registration_confirmation","subject","Reg Conf Confirmed");
  $t->setThirdPartySetting("registration_confirmation","message",["value"=>"<p>Thanks</p>","format"=>"basic_html"]);
  $t->save();
' >/dev/null 2>&1
echo "setup: registration.type.reg_conf confirmation enable=true subject='Reg Conf Confirmed'"
