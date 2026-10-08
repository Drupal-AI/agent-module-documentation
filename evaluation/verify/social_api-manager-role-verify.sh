#!/usr/bin/env bash
# Execution VERIFY: PASS when a role social_api_manager exists, holds
# "administer social api configuration" and therefore passes access on the
# social_api.admin_config route (/admin/config/social-api). It must NOT hold the four other
# social_api permissions. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\user\Entity\Role;
  $role = Role::load("social_api_manager");
  $perms = $role ? $role->getPermissions() : [];
  $has = in_array("administer social api configuration", $perms, TRUE);
  $extra = array_values(array_intersect($perms, [
    "administer social api authentication",
    "administer social api autoposting",
    "administer social api blocks",
    "administer social api widgets",
  ]));
  $route = \Drupal::service("router.route_provider")->getRouteByName("social_api.admin_config");
  $routePerm = $route->getRequirement("_permission");
  $ok = $role && $has && empty($extra) && $routePerm === "administer social api configuration";
  print ($ok ? "PASS" : "FAIL") . " role=" . ($role ? "yes" : "no")
    . " has_config_perm=" . ($has ? "yes" : "no")
    . " extra_perms=" . (empty($extra) ? "none" : implode("|", $extra))
    . " route_permission=" . $routePerm . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
