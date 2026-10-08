#!/usr/bin/env bash
# Execution VERIFY: run og_prepopulate's own populator service as ogp_task_user against an
# entity_autocomplete element pointing at the group node "OGP Task Group". PASS only when the
# override in Drupal\og_prepopulate\Populate::formatEntityAutocomplete() fires, i.e. the element
# gets #value "OGP Task Group (<nid>)" AND #access === FALSE - which happens only when
# Og::isMember() is TRUE for that user and group. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $found = \Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title" => "OGP Task Group"]);
  $user = user_load_by_name("ogp_task_user");
  if (!$found || !$user) { print "FAIL fixture missing\n"; return; }
  $group = reset($found);
  \Drupal::service("account_switcher")->switchTo($user);
  $element = ["target_id" => ["#type" => "entity_autocomplete", "#target_type" => "node"]];
  \Drupal::service("og_prepopulate.populator")->populateForm($element, ["target_id" => $group->id()]);
  \Drupal::service("account_switcher")->switchBack();
  $value = $element["target_id"]["#value"] ?? NULL;
  $access = $element["target_id"]["#access"] ?? NULL;
  $expected = $group->label() . " (" . $group->id() . ")";
  $ok = ($value === $expected) && ($access === FALSE);
  print ($ok ? "PASS" : "FAIL") . " value=" . var_export($value, TRUE) . " access=" . var_export($access, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
