#!/usr/bin/env bash
# Execution RESET: delete any fullcalendar_block instance whose event_source is /fcb-task-feed so verify
# FAILS until the agent places one. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  foreach (Block::loadMultiple() as $b) {
    if ($b->getPluginId() === "fullcalendar_block") {
      $s = $b->get("settings");
      if (($s["event_source"] ?? "") === "/fcb-task-feed") { $b->delete(); }
    }
  }
' >/dev/null 2>&1
echo "reset: removed any fullcalendar_block with event_source=/fcb-task-feed"
