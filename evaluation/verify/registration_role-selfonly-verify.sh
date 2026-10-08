#!/usr/bin/env bash
# Execution VERIFY: PASS when registration_role_selfonly is the only role assigned on
# registration AND registration_mode is 'user', i.e. administrator/CLI-created accounts must
# NOT get it. Proven live: a user created from the CLI must come out WITHOUT the role.
# The probe user is always deleted again. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\user\Entity\User;
  $c = \Drupal::config("registration_role.setting");
  $roles = array_keys(array_filter((array) $c->get("role_to_select")));
  $mode = $c->get("registration_mode");
  $cfgOk = ($roles === ["registration_role_selfonly"]) && ($mode === "user");
  $liveOk = FALSE; $granted = "n/a";
  try {
    if ($old = user_load_by_name("rr_selfonly_probe")) { $old->delete(); }
    $u = User::create(["name" => "rr_selfonly_probe", "mail" => "rr_selfonly_probe@example.com", "status" => 1]);
    $u->save();
    $granted = implode(",", $u->getRoles());
    $liveOk = !in_array("registration_role_selfonly", $u->getRoles(), TRUE);
    $u->delete();
  }
  catch (\Throwable $e) { $granted = "ERROR:" . $e->getMessage(); }
  $ok = $cfgOk && $liveOk;
  print ($ok ? "PASS" : "FAIL") . " roles=[" . implode(",", $roles) . "] mode=" . var_export($mode, TRUE)
    . " cli_user_roles=[" . $granted . "]\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
