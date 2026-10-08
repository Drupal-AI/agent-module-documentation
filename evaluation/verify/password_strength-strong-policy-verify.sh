#!/usr/bin/env bash
# Live-state verification for the hard "create a strong-password policy" task.
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# Passes when a password_policy config entity exists that carries the
# password_strength_constraint with a minimum strength_score of 4.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $ok = FALSE; $score = "none";
  foreach (\Drupal::entityTypeManager()->getStorage("password_policy")->loadMultiple() as $policy) {
    foreach ($policy->getConstraints() as $c) {
      if (($c["id"] ?? "") === "password_strength_constraint") {
        $score = $c["strength_score"] ?? "unset";
        if ((int) $score === 4) { $ok = TRUE; }
      }
    }
  }
  print ($ok ? "PASS" : "FAIL") . " strength_score=" . $score . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
