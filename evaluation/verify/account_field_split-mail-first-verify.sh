#!/usr/bin/env bash
# Live-state verification for "E-mail above Username on the account form".
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# Reads core.entity_form_display.user.user.default and checks:
#   vis — both mail and name are visible (present as components in the content region)
#   ord — mail's weight is strictly less than name's (mail sorts above name)
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $vis = FALSE; $ord = FALSE; $detail = "";
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("user.user.default");
  if ($fd) {
    $m = $fd->getComponent("mail");
    $n = $fd->getComponent("name");
    $mReg = is_array($m) ? ($m["region"] ?? "content") : "hidden";
    $nReg = is_array($n) ? ($n["region"] ?? "content") : "hidden";
    if (is_array($m) && is_array($n) && $mReg === "content" && $nReg === "content") {
      $vis = TRUE;
      $mw = (int) ($m["weight"] ?? 0);
      $nw = (int) ($n["weight"] ?? 0);
      if ($mw < $nw) { $ord = TRUE; }
      $detail = "mail_weight=" . $mw . " name_weight=" . $nw;
    } else {
      $detail = "mail_region=" . $mReg . " name_region=" . $nReg;
    }
  }
  $ok = $vis && $ord;
  print ($ok ? "PASS" : "FAIL") . " vis=" . ($vis?1:0) . " ord=" . ($ord?1:0) . " " . $detail . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
