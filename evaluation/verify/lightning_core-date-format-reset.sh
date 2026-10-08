#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# Execution RESET: delete the `long_12h` date format that Lightning Core ships, so the case
# starts from empty state and the agent must recreate it.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($e = \Drupal::entityTypeManager()->getStorage("date_format")->load("long_12h")) { $e->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: date format long_12h removed (clean state)"
