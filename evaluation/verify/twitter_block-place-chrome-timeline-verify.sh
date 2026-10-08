#!/usr/bin/env bash
# Live-state verification for the "place a chrome-stripped twitter_block timeline" task.
# PASS only if a block config entity exists that uses the `twitter_block` plugin AND
# has settings username=wikipedia, the default theme ('' / not dark), and BOTH chrome
# options `noheader` and `nofooter` enabled (truthy, not "0").
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $found = FALSE; $u=""; $nh=0; $nf=0;
  foreach (\Drupal::entityTypeManager()->getStorage("block")->loadMultiple() as $b) {
    if ($b->getPluginId() !== "twitter_block") { continue; }
    $s = $b->get("settings");
    $chrome = is_array($s["chrome"] ?? NULL) ? $s["chrome"] : [];
    $noheader = !empty($chrome["noheader"]) && $chrome["noheader"] !== "0";
    $nofooter = !empty($chrome["nofooter"]) && $chrome["nofooter"] !== "0";
    if (($s["username"] ?? "") === "wikipedia"
        && ($s["theme"] ?? "") === ""
        && $noheader && $nofooter) {
      $found = TRUE; $u=$s["username"]; $nh=1; $nf=1; break;
    }
  }
  print ($found ? "PASS" : "FAIL")
    . " found=" . ($found ? 1 : 0)
    . " username=" . $u . " noheader=" . $nh . " nofooter=" . $nf . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
