#!/usr/bin/env bash
# Execution VERIFY: create then delete a probe user_role config entity; the agent's delete
# subscriber must record "user_role/<id>" into state key entity_events_del.last. PASS when it
# matches. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\user\Entity\Role;
  \Drupal::state()->delete("entity_events_del.last");
  if ($r = Role::load("ee_probe_del")) { $r->delete(); }
  $r = Role::create(["id" => "ee_probe_del", "label" => "EE Probe Del"]);
  $r->save();
  $expect = "user_role/ee_probe_del";
  $r->delete();
  $v = \Drupal::state()->get("entity_events_del.last");
  print (($v === $expect) ? "PASS" : "FAIL") . " state=" . var_export($v, TRUE) . " expected=" . $expect . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
