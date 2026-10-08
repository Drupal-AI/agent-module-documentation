#!/usr/bin/env bash
# Execution VERIFY: PASS when a view_mode_page pattern exists with pattern /%/print and
# view_mode printable. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("view_mode_page_pattern");
  $ok = FALSE; $info = "";
  foreach ($s->loadMultiple() as $p) {
    if ($p->get("pattern") === "/%/print" && $p->get("view_mode") === "printable") {
      $ok = TRUE; $info = $p->id().":".$p->get("type"); break;
    }
  }
  print ($ok ? "PASS " : "FAIL ") . $info . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
