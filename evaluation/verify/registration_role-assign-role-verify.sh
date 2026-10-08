#!/usr/bin/env bash
# Execution VERIFY: PASS when registration_role is configured to grant registration_role_task
# in 'admin' mode AND a freshly created account really receives it. Because Drush runs as
# PHP_SAPI cli, registration_role treats it as an admin-created user, so the role is only
# granted when registration_mode is 'admin'. The probe user is always deleted again.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\user\Entity\User;
  $c = \Drupal::config("registration_role.setting");
  $roles = array_keys(array_filter((array) $c->get("role_to_select")));
  $mode = $c->get("registration_mode");
  $cfgOk = in_array("registration_role_task", $roles, TRUE) && ($mode === "admin");
  $liveOk = FALSE; $granted = "n/a";
  try {
    if ($old = user_load_by_name("rr_verify_probe")) { $old->delete(); }
    $u = User::create(["name" => "rr_verify_probe", "mail" => "rr_verify_probe@example.com", "status" => 1]);
    $u->save();
    $granted = implode(",", $u->getRoles());
    $liveOk = in_array("registration_role_task", $u->getRoles(), TRUE);
    $u->delete();
  }
  catch (\Throwable $e) { $granted = "ERROR:" . $e->getMessage(); }
  $ok = $cfgOk && $liveOk;
  print ($ok ? "PASS" : "FAIL") . " roles=[" . implode(",", $roles) . "] mode=" . var_export($mode, TRUE)
    . " new_user_roles=[" . $granted . "]\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
