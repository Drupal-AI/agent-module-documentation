#!/usr/bin/env bash
# Introspection SETUP: create registration type reg_ovr with the CAPACITY override enabled (only).
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\registration\Entity\RegistrationType;
  $t = RegistrationType::load("reg_ovr") ?: RegistrationType::create(["id"=>"reg_ovr"]);
  $t->set("label","Reg Ovr")->set("workflow","registration")->set("defaultState","pending")->set("heldExpireState","canceled");
  foreach (["status","maximum_spaces","capacity","open","close"] as $k) { $t->setThirdPartySetting("registration_admin_overrides",$k,$k==="capacity"); }
  $t->save();
' >/dev/null 2>&1
echo "setup: registration.type.reg_ovr admin override capacity=true (others false)"
