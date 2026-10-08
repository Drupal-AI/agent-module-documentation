#!/usr/bin/env bash
# Execution VERIFY: PASS when the phd_lock_admin role has been granted the module's
# delete_homepage_node permission AND, as a result, phd_lock_user really may delete the
# protected node "PHD Locked Page" (live node access check). Also asserts the node is still
# listed in protected_urls, so the fix must be the permission, not un-protecting the page.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\user\Entity\Role;
  $storage = \Drupal::entityTypeManager()->getStorage("node");
  $found = $storage->loadByProperties(["title" => "PHD Locked Page"]);
  $user = user_load_by_name("phd_lock_user");
  $role = Role::load("phd_lock_admin");
  if (!$found || !$user || !$role) { print "FAIL fixture missing\n"; return; }
  $node = reset($found);
  $protected = (string) \Drupal::config("prevent_homepage_deletion.settings")->get("protected_urls");
  $still_protected = str_contains($protected, "/node/" . $node->id());
  $has_perm = $role->hasPermission("delete_homepage_node");
  \Drupal::entityTypeManager()->getAccessControlHandler("node")->resetCache();
  $can_delete = $node->access("delete", $user);
  $ok = $still_protected && $has_perm && $can_delete;
  print ($ok ? "PASS" : "FAIL") . " still_protected=" . var_export($still_protected, TRUE) .
    " role_perm=" . var_export($has_perm, TRUE) . " can_delete=" . var_export($can_delete, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
