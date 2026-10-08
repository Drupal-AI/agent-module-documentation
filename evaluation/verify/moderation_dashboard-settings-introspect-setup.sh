#!/usr/bin/env bash
# MEDIUM setup: put moderation_dashboard.settings into a KNOWN non-default state so the
# agent must read the live config to answer. Defaults are redirect_on_login=true,
# chart_js_cdn=false; we flip BOTH (redirect_on_login=false, chart_js_cdn=true).
# SPDX-License-Identifier: GPL-2.0-or-later
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("moderation_dashboard.settings")
    ->set("redirect_on_login", FALSE)
    ->set("chart_js_cdn", TRUE)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: moderation_dashboard.settings set to redirect_on_login=false, chart_js_cdn=true"
