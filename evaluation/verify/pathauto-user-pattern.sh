#!/usr/bin/env bash
# Live-state verification for the "User -> users/[user:account-name]" pathauto task.
# Prints PASS/FAIL and exits 0/1.
#   cfg — an enabled pathauto_pattern of type user with pattern users/[user:account-name]
#   fn  — a freshly-created user actually receives a /users/<name> URL alias
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $cfg = FALSE;
  foreach (\Drupal::entityTypeManager()->getStorage("pathauto_pattern")->loadMultiple() as $p) {
    if ($p->status() && $p->getType() === "canonical_entities:user"
        && stripos($p->getPattern(), "users/[user:account-name]") !== FALSE) { $cfg = TRUE; }
  }
  $name = "evaluser" . substr(md5(microtime()), 0, 6);
  $u = \Drupal\user\Entity\User::create(["name" => $name, "mail" => $name . "@example.com", "status" => 1]);
  $u->save();  // pathauto entity hooks generate the alias on save if a user pattern matches
  $alias = \Drupal::service("path_alias.manager")->getAliasByPath("/user/" . $u->id());
  $fn = str_starts_with($alias, "/users/");
  $u->delete();
  print ($cfg && $fn ? "PASS" : "FAIL") . " cfg=" . ($cfg?1:0) . " fn=" . ($fn?1:0) . " alias=" . $alias . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
