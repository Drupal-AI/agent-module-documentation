#!/usr/bin/env bash
# Execution VERIFY: PASS when an anonymous user can actually VIEW the published sstp_view_type
# site setting entity, granted through the submodule's per-type permission rather than the
# global one (the global 'view published site setting entities' must stay revoked for anonymous).
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\user\Entity\Role;
  use Drupal\user\Entity\User;
  $anon = Role::load("anonymous");
  $perms = $anon ? $anon->getPermissions() : [];
  $global = in_array("view published site setting entities", $perms, TRUE);
  $typed = in_array("view published sstp_view_type site setting entities", $perms, TRUE);
  $entities = \Drupal::entityTypeManager()->getStorage("site_setting_entity")->loadByProperties(["type" => "sstp_view_type"]);
  if (!$entities) { print "FAIL no sstp_view_type site setting entity\n"; return; }
  $entity = reset($entities);
  $account = User::load(0);
  $access = $entity->access("view", $account);
  $ok = $access && $typed && !$global;
  print ($ok ? "PASS" : "FAIL") . " anon_view_access=" . var_export((bool) $access, TRUE)
    . " per_type_perm=" . var_export($typed, TRUE)
    . " global_perm=" . var_export($global, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
