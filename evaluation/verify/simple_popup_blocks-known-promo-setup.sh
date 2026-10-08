#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# Introspection SETUP: write a KNOWN Simple Popup Blocks popup config object so an inspecting
# agent can read its identifier/layout/trigger back with drush. Creates
# simple_popup_blocks.popup_known_promo targeting custom CSS id #promo-banner (type 1,
# css_selector 1), layout 6 (top bar), trigger_method 1 (manual on click of #open-promo),
# enabled. Idempotent (overwritten each run). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("simple_popup_blocks.popup_known_promo")
    ->set("uid", "known_promo")
    ->set("identifier", "promo-banner")
    ->set("type", 1)
    ->set("css_selector", 1)
    ->set("layout", 6)
    ->set("trigger_method", 1)
    ->set("trigger_selector", "#open-promo")
    ->set("delay", 0)
    ->set("visit_counts", serialize([0 => "0"]))
    ->set("use_time_frequency", FALSE)
    ->set("time_frequency", 3600)
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
echo "setup: simple_popup_blocks.popup_known_promo (promo-banner, layout 6 top-bar, trigger_method 1 manual #open-promo)"
