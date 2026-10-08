#!/usr/bin/env bash
# Execution VERIFY: PASS when registration_type reg_build exists with workflow=registration,
# defaultState=pending, heldExpireTime=24, heldExpireState=canceled. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\registration\Entity\RegistrationType;
  $t = RegistrationType::load("reg_build");
  if (!$t) { print "FAIL missing\n"; return; }
  $ok = ($t->getWorkflowId() === "registration")
     && ($t->getDefaultState() === "pending")
     && ((int) $t->getHeldExpirationTime() === 24)
     && ($t->getHeldExpirationState() === "canceled");
  print ($ok ? "PASS" : "FAIL")." workflow=".$t->getWorkflowId()." default=".$t->getDefaultState()." held=".$t->getHeldExpirationTime()."/".$t->getHeldExpirationState()."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
