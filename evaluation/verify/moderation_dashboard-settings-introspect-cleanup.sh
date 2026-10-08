#!/usr/bin/env bash
# MEDIUM cleanup: restore moderation_dashboard.settings to install defaults
# (redirect_on_login=true, chart_js_cdn=false).
# SPDX-License-Identifier: GPL-2.0-or-later
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("moderation_dashboard.settings")
    ->set("redirect_on_login", TRUE)
    ->set("chart_js_cdn", FALSE)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: moderation_dashboard.settings restored to defaults (redirect_on_login=true, chart_js_cdn=false)"
