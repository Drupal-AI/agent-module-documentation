#!/usr/bin/env bash
# Execution VERIFY for "generate/assign an API key for ka_client".
# PASS when user ka_client has a NON-EMPTY api_key whose length equals the currently
# configured key_auth.settings key_length. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\user\Entity\User;

  $uids = \Drupal::entityQuery("user")
    ->accessCheck(FALSE)
    ->condition("name", "ka_client")
    ->execute();
  $user = $uids ? User::load(reset($uids)) : NULL;
  $key = $user ? $user->get("api_key")->value : NULL;
  $expected_length = (int) \Drupal::config("key_auth.settings")->get("key_length");
  $ok = $user && !empty($key) && strlen($key) === $expected_length;
  print ($ok ? "PASS" : "FAIL") . " key=" . var_export($key, TRUE) . " len=" . ($key ? strlen($key) : 0) . " expected_length=" . $expected_length . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
