#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# HARD (execution) live-state verification for the "ban the bot IP" task.
# Prints PASS/FAIL and exits 0 (pass) / 1 (fail). No arguments.
# PASS when 203.0.113.99 is present in the core Ban list (ban.ip_manager->isBanned),
# i.e. the agent produced the same end state perimeter's ban logic would.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $banned = \Drupal::service("ban.ip_manager")->isBanned("203.0.113.99");
  print ($banned ? "PASS" : "FAIL") . " isBanned=" . ($banned?1:0) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
