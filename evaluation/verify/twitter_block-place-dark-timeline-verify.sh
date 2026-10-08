#!/usr/bin/env bash
# Live-state verification for the "place a dark twitter_block timeline" task.
# PASS only if a block config entity exists that uses the `twitter_block` plugin AND
# has settings username=drupal, theme=dark, tweet_limit=5.
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $found = FALSE; $u=""; $t=""; $tl="";
  foreach (\Drupal::entityTypeManager()->getStorage("block")->loadMultiple() as $b) {
    if ($b->getPluginId() !== "twitter_block") { continue; }
    $s = $b->get("settings");
    if (($s["username"] ?? "") === "drupal"
        && ($s["theme"] ?? "") === "dark"
        && (string) ($s["tweet_limit"] ?? "") === "5") {
      $found = TRUE; $u=$s["username"]; $t=$s["theme"]; $tl=(string)$s["tweet_limit"]; break;
    }
  }
  print ($found ? "PASS" : "FAIL")
    . " found=" . ($found ? 1 : 0)
    . " username=" . $u . " theme=" . $t . " tweet_limit=" . $tl . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
