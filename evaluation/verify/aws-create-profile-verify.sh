#!/usr/bin/env bash
# Execution VERIFY: PASS when an AWS profile exists with region eu-central-1 marked as default.
# Prints PASS/FAIL; exit 0 pass / 1 fail. No AWS calls.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("aws_profile");
  $match = NULL;
  foreach ($s->loadMultiple() as $p) {
    if ($p->getRegion() === "eu-central-1" && $p->isDefault()) { $match = $p->id(); break; }
  }
  print ($match ? "PASS id=".$match : "FAIL no default profile with region eu-central-1") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
