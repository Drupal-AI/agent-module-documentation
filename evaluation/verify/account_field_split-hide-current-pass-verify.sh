#!/usr/bin/env bash
# Live-state verification for "hide the Current password field on the account form".
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# Reads core.entity_form_display.user.user.default and checks that the account_field_split
# `current_pass` pseudo-field is NOT visible: either it has no content-region component
# (getComponent() returns null → moved to the hidden region) or its region is "hidden".
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $hid = FALSE; $detail = "";
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("user.user.default");
  if ($fd) {
    $c = $fd->getComponent("current_pass");
    if (!is_array($c)) {
      $hid = TRUE; $detail = "component=none(hidden)";
    } else {
      $reg = $c["region"] ?? "content";
      if ($reg === "hidden") { $hid = TRUE; }
      $detail = "region=" . $reg;
    }
    // Double-check the hidden section of the config as a belt-and-braces read.
    $hidden = $fd->get("hidden") ?: [];
    if (!empty($hidden["current_pass"])) { $hid = TRUE; $detail .= " hidden_flag=1"; }
  }
  print ($hid ? "PASS" : "FAIL") . " hid=" . ($hid?1:0) . " " . $detail . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
