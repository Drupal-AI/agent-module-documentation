#!/usr/bin/env bash
# Execution VERIFY: PASS when the module forces Dutch and prevents override, proven at runtime:
#   (a) config default_language_to_assign === 'nl' AND prevent_user_override === TRUE, AND
#   (b) a freshly created+saved user gets preferred_admin_langcode === 'nl' (the presave hook fired).
# Creates and deletes its own throwaway user 'aul_verify_user'. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\user\Entity\User;
  $c = \Drupal::config("admin_user_language.settings");
  $lang = $c->get("default_language_to_assign");
  $prev = $c->get("prevent_user_override");
  if ($u = user_load_by_name("aul_verify_user")) { $u->delete(); }
  $u = User::create(["name"=>"aul_verify_user","mail"=>"aul_verify_user@example.com","status"=>1]);
  $u->save();
  $applied = $u->get("preferred_admin_langcode")->value;
  $u->delete();
  $ok = ($lang === "nl" && $prev === TRUE && $applied === "nl");
  print ($ok ? "PASS" : "FAIL") . " lang=" . var_export($lang, TRUE) . " prevent=" . var_export($prev, TRUE) . " applied=" . var_export($applied, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
