#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# Live-state verification for "create a node view mode eval_summary, marked internal with a
# description via Lightning Core's view-mode third-party settings". PASS (exit 0) when the
# core.entity_view_mode.node.eval_summary config entity exists with
# third_party_settings.lightning_core.internal === TRUE and a non-empty
# lightning_core.description. Prints PASS/FAIL with detail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ok = FALSE; $detail = " missing";
  if ($vm = \Drupal::entityTypeManager()->getStorage("entity_view_mode")->load("node.eval_summary")) {
    $internal = (bool) $vm->getThirdPartySetting("lightning_core", "internal");
    $desc = (string) $vm->getThirdPartySetting("lightning_core", "description");
    $detail = " internal=" . ($internal?1:0) . " desc=\"" . $desc . "\"";
    if ($internal && $desc !== "") { $ok = TRUE; }
  }
  print ($ok ? "PASS" : "FAIL") . $detail . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
