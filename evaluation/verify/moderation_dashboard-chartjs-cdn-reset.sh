#!/usr/bin/env bash
# HARD reset: put chart_js_cdn back to its install DEFAULT (false = local library), so the
# task "load Chart.js from the CDN" starts from a state where the CDN is NOT yet enabled.
# Safe to run repeatedly.
# SPDX-License-Identifier: GPL-2.0-or-later
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("moderation_dashboard.settings")
    ->set("chart_js_cdn", FALSE)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: chart_js_cdn=false (default/local) restored"
