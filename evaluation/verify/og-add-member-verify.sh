#!/usr/bin/env bash
# Execution VERIFY: PASS when og_task_member has an ACTIVE og_membership in the group node
# "OG Task Club" carrying the group's administrator OG role, and OG really grants them the
# group-level "manage members" permission there. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\og\OgMembershipInterface;
  $storage = \Drupal::entityTypeManager()->getStorage("node");
  $found = $storage->loadByProperties(["title" => "OG Task Club"]);
  $user = user_load_by_name("og_task_member");
  if (!$found || !$user) { print "FAIL fixture missing\n"; return; }
  $group = reset($found);
  $membership = \Drupal::service("og.membership_manager")->getMembership($group, $user->id(), OgMembershipInterface::ALL_STATES);
  if (!$membership) { print "FAIL no og_membership for og_task_member in OG Task Club\n"; return; }
  $state = $membership->getState();
  $roles = $membership->getRolesIds();
  $has_admin = in_array("node-og_agrp-administrator", $roles, TRUE);
  $can_manage = \Drupal::service("og.access")->userAccess($group, "manage members", $user)->isAllowed();
  $ok = ($state === OgMembershipInterface::STATE_ACTIVE) && $has_admin && $can_manage;
  print ($ok ? "PASS" : "FAIL") . " state=" . $state . " roles=" . implode("|", $roles) .
    " manage_members=" . var_export($can_manage, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
