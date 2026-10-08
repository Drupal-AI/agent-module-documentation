#!/usr/bin/env bash
# Execution VERIFY: PASS when Flag Anonymous is enabled on flaganon_eval
# (third_party_settings.flag_anon.enabled is truthy). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $f = \Drupal::entityTypeManager()->getStorage("flag")->load("flaganon_eval");
  $en = $f ? $f->getThirdPartySetting("flag_anon","enabled",0) : NULL;
  $ok = !empty($en);
  print ($ok ? "PASS" : "FAIL") . " enabled=" . var_export($en, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
