#!/usr/bin/env bash
# Execution VERIFY: PASS when group type grequest_htype has the group_membership_request relation
# installed. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\group\Entity\GroupType;
  $gt = GroupType::load("grequest_htype");
  $ok = $gt && $gt->hasPlugin("group_membership_request");
  print ($ok ? "PASS" : "FAIL") . " grequest_htype has_plugin=" . ($ok ? "yes" : "no") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
