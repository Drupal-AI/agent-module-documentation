#!/usr/bin/env bash
# Execution VERIFY: PASS when add_to_head.settings has at least one profile with
# scope === 'head' whose code contains the marker <meta name="ath-verify" content="ok">.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $profiles = \Drupal::config("add_to_head.settings")->get("add_to_head_profiles") ?? [];
  $marker = "<meta name=\"ath-verify\" content=\"ok\">";
  $ok = FALSE;
  foreach ($profiles as $profile) {
    if (($profile["scope"] ?? NULL) === "head" && str_contains((string) ($profile["code"] ?? ""), $marker)) {
      $ok = TRUE;
      break;
    }
  }
  print ($ok ? "PASS" : "FAIL") . " profiles=" . count($profiles) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
