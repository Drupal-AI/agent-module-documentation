#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# Live-state verification for "create a user role eval_content_editor with a Lightning Core
# description". PASS (exit 0) when the user.role.eval_content_editor config entity exists and
# carries a non-empty description under third_party_settings.lightning_core.description.
# Prints PASS/FAIL with detail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ok = FALSE; $detail = " missing";
  if ($r = \Drupal::entityTypeManager()->getStorage("user_role")->load("eval_content_editor")) {
    $desc = (string) $r->getThirdPartySetting("lightning_core", "description");
    $detail = " label=" . $r->label() . " desc=\"" . $desc . "\"";
    if ($desc !== "") { $ok = TRUE; }
  }
  print ($ok ? "PASS" : "FAIL") . $detail . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
