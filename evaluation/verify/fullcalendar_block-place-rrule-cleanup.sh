#!/usr/bin/env bash
# Execution CLEANUP: delete any fullcalendar_block instance with event_source=/fcb-rrule-feed. Idempotent.
# FAILS until the agent places one with rrule enabled. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  foreach (Block::loadMultiple() as $b) {
    if ($b->getPluginId() === "fullcalendar_block") {
      $s = $b->get("settings");
      if (($s["event_source"] ?? "") === "/fcb-rrule-feed") { $b->delete(); }
    }
  }
' >/dev/null 2>&1
echo "cleanup: removed any fullcalendar_block with event_source=/fcb-rrule-feed"
