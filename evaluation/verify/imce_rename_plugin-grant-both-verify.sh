#!/usr/bin/env bash
# imce_rename_plugin execution VERIFY: PASS when imce.profile.imcerp_both folder[0] has BOTH
# rename_files AND rename_folders === TRUE. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $p = \Drupal::entityTypeManager()->getStorage("imce_profile")->load("imcerp_both");
  if (!$p) { print "FAIL no-profile\n"; return; }
  $perm = $p->get("conf")["folders"][0]["permissions"] ?? [];
  $rf = $perm["rename_files"] ?? NULL; $rfo = $perm["rename_folders"] ?? NULL;
  $ok = ($rf === TRUE) && ($rfo === TRUE);
  print ($ok ? "PASS" : "FAIL") . " rename_files=" . var_export($rf, TRUE) . " rename_folders=" . var_export($rfo, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
