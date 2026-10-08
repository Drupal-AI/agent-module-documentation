#!/usr/bin/env bash
# HARD reset: put redirect_on_login back to its install DEFAULT (true), so the task
# "disable the after-login redirect" starts from a state where it is NOT yet disabled.
# Leaves chart_js_cdn at its default (false) too. Safe to run repeatedly.
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
echo "reset: redirect_on_login=true (default) restored"
