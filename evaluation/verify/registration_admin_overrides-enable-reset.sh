#!/usr/bin/env bash
# Execution RESET: registration type reg_ovr exists with ALL admin overrides FALSE.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\registration\Entity\RegistrationType;
  $t = RegistrationType::load("reg_ovr") ?: RegistrationType::create(["id"=>"reg_ovr"]);
  $t->set("label","Reg Ovr")->set("workflow","registration")->set("defaultState","pending")->set("heldExpireState","canceled");
  foreach (["status","maximum_spaces","capacity","open","close"] as $k) { $t->setThirdPartySetting("registration_admin_overrides",$k,FALSE); }
  $t->save();
' >/dev/null 2>&1
echo "reset: registration.type.reg_ovr all admin overrides FALSE"
