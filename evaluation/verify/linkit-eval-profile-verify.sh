#!/usr/bin/env bash
# Live-state verification for the "create a Linkit profile with a node/entity matcher" task.
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# PASS only if the linkit_profile config entity `eval_profile` exists AND carries at least
# one matcher instance (an entity matcher such as entity:node).
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $p = \Drupal::entityTypeManager()->getStorage("linkit_profile")->load("eval_profile");
  $exists = (bool) $p;
  $matchers = $exists ? ($p->get("matchers") ?: []) : [];
  $count = is_array($matchers) ? count($matchers) : 0;
  $has_matcher = $count > 0;
  print (($exists && $has_matcher) ? "PASS" : "FAIL")
    . " exists=" . ($exists?1:0) . " matchers=" . $count . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
