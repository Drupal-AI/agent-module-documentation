#!/usr/bin/env bash
# Execution VERIFY: PASS when facebook_pixel.settings holds the pixel id 987654321098765 AND
# tracking is limited to the listed roles, with 'authenticated' among them.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("facebook_pixel.settings");
  $id = (string) $c->get("facebook_id");
  $mode = (string) $c->get("visibility.user_role_mode");
  $roles = array_values((array) $c->get("visibility.user_role_roles"));
  $ok = ($id === "987654321098765")
    && ($mode === "listed_roles")
    && in_array("authenticated", $roles, TRUE);
  print ($ok ? "PASS" : "FAIL") . " facebook_id=" . $id
    . " user_role_mode=" . $mode
    . " roles=" . implode(",", $roles) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
