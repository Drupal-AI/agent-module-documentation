#!/usr/bin/env bash
# Execution VERIFY: PASS when the Linkit profile lml_task_profile contains an entity:media
# matcher whose settings.bundles restrict it to the 'document' media type - the configuration
# linkit_media_library reads in getDynamicPluginConfig() to build its media library dialog.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\linkit\Entity\Profile;
  $p = Profile::load("lml_task_profile");
  if (!$p) { print "FAIL profile lml_task_profile missing\n"; return; }
  $found = NULL;
  foreach ($p->getMatchers() as $m) {
    if ($m->getPluginId() === "entity:media") { $found = $m->getConfiguration(); }
  }
  if (!$found) { print "FAIL no entity:media matcher on lml_task_profile\n"; return; }
  $bundles = array_filter((array) ($found["settings"]["bundles"] ?? []));
  $ok = (array_keys($bundles) === ["document"]);
  print ($ok ? "PASS" : "FAIL") . " bundles=" . json_encode($bundles) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
