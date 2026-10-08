#!/usr/bin/env bash
# Execution VERIFY: create a probe user_role config entity; the agent's insert subscriber must
# record "user_role/<id>" into state key entity_events_ins.last. PASS when it matches. Removes
# the probe role regardless. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\user\Entity\Role;
  \Drupal::state()->delete("entity_events_ins.last");
  if ($r = Role::load("ee_probe_ins")) { $r->delete(); }
  $r = Role::create(["id" => "ee_probe_ins", "label" => "EE Probe Ins"]);
  $r->save();
  $expect = "user_role/ee_probe_ins";
  $v = \Drupal::state()->get("entity_events_ins.last");
  $r->delete();
  print (($v === $expect) ? "PASS" : "FAIL") . " state=" . var_export($v, TRUE) . " expected=" . $expect . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
