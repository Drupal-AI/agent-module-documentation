#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# Introspection SETUP: write a KNOWN Simple Popup Blocks popup that throttles by TIME rather
# than visit count, so an inspecting agent can read the display frequency back. Creates
# simple_popup_blocks.popup_known_news (custom CSS id #news-signup, type 1) with
# use_time_frequency = TRUE and time_frequency = 86400 (daily), enabled. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("simple_popup_blocks.popup_known_news")
    ->set("uid", "known_news")
    ->set("identifier", "news-signup")
    ->set("type", 1)
    ->set("css_selector", 1)
    ->set("layout", 4)
    ->set("trigger_method", 0)
    ->set("trigger_selector", "")
    ->set("delay", 0)
    ->set("visit_counts", serialize([0 => "0"]))
    ->set("use_time_frequency", TRUE)
    ->set("time_frequency", 86400)
    ->set("overlay", TRUE)
    ->set("enable_escape", TRUE)
    ->set("close", TRUE)
    ->set("minimize", TRUE)
    ->set("show_minimized_button", FALSE)
    ->set("width", 400)
    ->set("cookie_expiry", 100)
    ->set("status", 1)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: simple_popup_blocks.popup_known_news (use_time_frequency TRUE, time_frequency 86400 daily)"
