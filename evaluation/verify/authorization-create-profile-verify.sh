#!/usr/bin/env bash
# HARD execution verify: at least one authorization_profile config entity must exist that
# uses the bundled Drupal Roles consumer (authorization_drupal_roles) AND has at least one
# consumer mapping naming a role. Prints PASS/FAIL, exits 0 (pass) / 1 (fail). No arguments.
# Iterates config directly (any id the agent chose is accepted) and filters unrelated
# deprecation/notice noise from other contrib modules out of the drush output.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $ok = FALSE; $found = ""; $consumer = ""; $roles = "";
  foreach (\Drupal::entityTypeManager()->getStorage("authorization_profile")->loadMultiple() as $p) {
    if ($p->getConsumerId() === "authorization_drupal_roles") {
      $maps = $p->getConsumerMappings();
      $has_role = FALSE; $rlist = [];
      foreach ((array) $maps as $m) {
        if (!empty($m["role"])) { $has_role = TRUE; $rlist[] = $m["role"]; }
      }
      if ($has_role) {
        $ok = TRUE; $found = $p->id(); $consumer = $p->getConsumerId(); $roles = implode(",", $rlist);
        break;
      }
    }
  }
  print ($ok ? "PASS" : "FAIL") . " id=" . $found . " consumer=" . $consumer . " roles=" . $roles . "\n";
' 2>/dev/null | grep -Ev '^\s*(Deprecated|Warning|Notice):' | grep -E '^(PASS|FAIL)')

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
