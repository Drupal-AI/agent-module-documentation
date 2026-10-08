#!/usr/bin/env bash
# Execution VERIFY: PASS when the OG role node-ogui_tgrp-member carries the group permission
# 'manage members' AND the plain member ogui_task_user is really granted it by og.access on the
# group node "OG UI Task Club". Also asserts the fix was made on the member role, not by making
# the user an administrator. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\og\Entity\OgRole;
  use Drupal\og\OgMembershipInterface;
  $role = OgRole::load("node-ogui_tgrp-member");
  $found = \Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title" => "OG UI Task Club"]);
  $user = user_load_by_name("ogui_task_user");
  if (!$role || !$found || !$user) { print "FAIL fixture missing\n"; return; }
  $group = reset($found);
  $membership = \Drupal::service("og.membership_manager")->getMembership($group, $user->id(), OgMembershipInterface::ALL_STATES);
  $roles = $membership ? $membership->getRolesIds() : [];
  $only_member = $roles === ["node-ogui_tgrp-member"];
  $role_has = $role->hasPermission("manage members");
  $granted = \Drupal::service("og.access")->userAccess($group, "manage members", $user)->isAllowed();
  $ok = $role_has && $granted && $only_member;
  print ($ok ? "PASS" : "FAIL") . " role_has=" . var_export($role_has, TRUE) . " granted=" .
    var_export($granted, TRUE) . " membership_roles=" . implode("|", $roles) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
