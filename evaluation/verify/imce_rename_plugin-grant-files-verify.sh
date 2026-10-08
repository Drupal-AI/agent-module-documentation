#!/usr/bin/env bash
# imce_rename_plugin execution VERIFY: PASS when imce.profile.imcerp_task folder[0] has rename_files === TRUE.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $p = \Drupal::entityTypeManager()->getStorage("imce_profile")->load("imcerp_task");
  if (!$p) { print "FAIL no-profile\n"; return; }
  $rf = $p->get("conf")["folders"][0]["permissions"]["rename_files"] ?? NULL;
  print (($rf === TRUE) ? "PASS" : "FAIL") . " rename_files=" . var_export($rf, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
