#!/usr/bin/env bash
# Execution VERIFY (tocbot): PASS when tocbot.settings min_activate == 6 AND heading_selector
# includes h2 and h3 but NOT h4/h5/h6 (i.e. TOC only from h2+h3, activating at 6 headings).
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("tocbot.settings");
  $min = (string) $c->get("min_activate");
  $hs = strtolower((string) $c->get("heading_selector"));
  $has_h2 = strpos($hs, "h2") !== FALSE;
  $has_h3 = strpos($hs, "h3") !== FALSE;
  $no_deep = (strpos($hs, "h4") === FALSE && strpos($hs, "h5") === FALSE && strpos($hs, "h6") === FALSE);
  $ok = ($min === "6" && $has_h2 && $has_h3 && $no_deep);
  print ($ok ? "PASS" : "FAIL") . " min_activate=" . $min . " heading_selector=\"" . $hs . "\"\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
