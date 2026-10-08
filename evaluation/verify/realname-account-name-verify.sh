#!/usr/bin/env bash
# Live-state verification for the "set the account-name fallback pattern and rebuild" task.
# Prints PASS/FAIL with detail; exits 0 (pass) / 1 (fail). No arguments.
# Two independent checks:
#   cfg — realname.settings:pattern is exactly [user:account-name]
#   fn  — a freshly-created user's COMPUTED real name equals that user's login name
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $pattern = (string) \Drupal::config("realname.settings")->get("pattern");
  $cfg = (trim($pattern) === "[user:account-name]");
  $suffix = substr(md5(microtime()), 0, 6);
  $uname = "eval_realname_$suffix";
  $account = \Drupal\user\Entity\User::create([
    "name" => $uname,
    "mail" => "eval_$suffix@example.com",
    "status" => 1,
  ]);
  $account->save();
  $realname = realname_update($account);
  $fn = ($realname === $uname);
  $account->delete();
  print (($cfg && $fn) ? "PASS" : "FAIL") . " cfg=" . ($cfg?1:0) . " fn=" . ($fn?1:0) . " pattern=" . $pattern . " realname=" . $realname . "\n";
' 2>/dev/null)

echo "$out" | grep -E '^(PASS|FAIL) '
echo "$out" | grep -q '^PASS ' && exit 0 || exit 1
