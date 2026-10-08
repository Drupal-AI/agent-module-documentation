#!/usr/bin/env bash
# Execution VERIFY: PASS when a fullcalendar_block instance with event_source=/fcb-rrule-feed AND rrule in
# its plugins exists. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\block\Entity\Block;
  $found = "none";
  foreach (Block::loadMultiple() as $b) {
    if ($b->getPluginId() === "fullcalendar_block") {
      $s = $b->get("settings");
      $plugins = (array) ($s["plugins"] ?? []);
      if (($s["event_source"] ?? "") === "/fcb-rrule-feed" && in_array("rrule", $plugins, TRUE)) { $found = $b->id(); break; }
    }
  }
  print (($found !== "none") ? "PASS" : "FAIL") . " block=" . $found . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
