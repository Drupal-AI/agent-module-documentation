#!/usr/bin/env bash
# Execution VERIFY for "register an RS256 public key with id usersjwt_task for
# user 1". PASS iff users_jwt.key_repository->getKey('usersjwt_task') returns a
# UsersKey with alg === 'RS256' and uid === 1. Prints PASS/FAIL; exit 0 pass /
# 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $key = \Drupal::service("users_jwt.key_repository")->getKey("usersjwt_task");
  $ok = ($key instanceof \Drupal\users_jwt\UsersKey) && $key->alg === "RS256" && $key->uid === 1;
  print ($ok ? "PASS" : "FAIL") . " uid=" . var_export($key->uid ?? NULL, TRUE) . " alg=" . var_export($key->alg ?? NULL, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
