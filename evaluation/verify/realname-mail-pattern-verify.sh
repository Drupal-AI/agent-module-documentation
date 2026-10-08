#!/usr/bin/env bash
# Live-state verification for the "set realname pattern to [user:mail] and rebuild" task.
# Prints PASS/FAIL with detail; exits 0 (pass) / 1 (fail). No arguments.
# Two independent checks:
#   cfg — realname.settings:pattern contains the [user:mail] token
#   fn  — a freshly-created user's COMPUTED real name equals that user's email
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $pattern = (string) \Drupal::config("realname.settings")->get("pattern");
  $cfg = (stripos($pattern, "[user:mail]") !== FALSE);
  $suffix = substr(md5(microtime()), 0, 6);
  $mail = "eval_$suffix@example.com";
  $account = \Drupal\user\Entity\User::create([
    "name" => "eval_realname_$suffix",
    "mail" => $mail,
    "status" => 1,
  ]);
  $account->save();
  $realname = realname_update($account);
  $fn = ($realname === $mail);
  $account->delete();
  print (($cfg && $fn) ? "PASS" : "FAIL") . " cfg=" . ($cfg?1:0) . " fn=" . ($fn?1:0) . " pattern=" . $pattern . " realname=" . $realname . "\n";
' 2>/dev/null)

echo "$out" | grep -E '^(PASS|FAIL) '
echo "$out" | grep -q '^PASS ' && exit 0 || exit 1
