#!/usr/bin/env bash
# Execution RESET: reg_wl registration type exists with wait-list confirmation email DISABLED.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\registration\Entity\RegistrationType;
  $t = RegistrationType::load("reg_wl") ?: RegistrationType::create(["id"=>"reg_wl"]);
  $t->set("label","Reg WL")->set("workflow","registration")->set("defaultState","pending")->set("heldExpireState","canceled");
  $t->setThirdPartySetting("registration_waitlist","confirmation_email",FALSE);
  $t->save();
' >/dev/null 2>&1
echo "reset: registration.type.reg_wl waitlist confirmation_email=FALSE"
