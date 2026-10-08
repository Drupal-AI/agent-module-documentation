#!/usr/bin/env bash
# HARD VERIFY: PASS when a Microsite entity named "EHM Task Site" exists whose home points at
# the "EHM Task Home" node. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ms = \Drupal::entityTypeManager()->getStorage("entity_hierarchy_microsite")->loadByProperties(["name" => "EHM Task Site"]);
  $ms = $ms ? reset($ms) : NULL;
  $home = \Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title" => "EHM Task Home"]);
  $home = $home ? reset($home) : NULL;
  $ok = FALSE; $hid = "none";
  if ($ms) { $hid = $ms->get("home")->target_id ?? "none"; $ok = ($home && (string)$hid === (string)$home->id()); }
  print ($ok ? "PASS" : "FAIL") . " microsite=" . ($ms ? "yes" : "no") . " home=" . $hid . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
