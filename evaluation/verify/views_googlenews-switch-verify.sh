#!/usr/bin/env bash
# Execution VERIFY: PASS when view 'vgn_switch' has a display whose style plugin is google_news
# AND row plugin is google_news_fields. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\views\Entity\View;
  $v = View::load("vgn_switch");
  $ok = FALSE; $style = "none"; $row = "none";
  if ($v) {
    foreach ($v->get("display") as $d) {
      $s = $d["display_options"]["style"]["type"] ?? NULL;
      $r = $d["display_options"]["row"]["type"] ?? NULL;
      if ($s === "google_news" && $r === "google_news_fields") { $ok = TRUE; $style = $s; $row = $r; break; }
      if ($s) { $style = $s; } if ($r) { $row = $r; }
    }
  }
  print ($ok ? "PASS" : "FAIL") . " style=" . $style . " row=" . $row . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
