#!/usr/bin/env bash
# Execution VERIFY: PASS when the acbb_tray view's add_content_by_bundle footer handler has
# target === "tray" (off-canvas). Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\views\Entity\View;
  $v = View::load("acbb_tray");
  $c = $v ? ($v->getDisplay("default")["display_options"]["footer"]["add_content_by_bundle"] ?? NULL) : NULL;
  $target = is_array($c) ? ($c["target"] ?? "") : "";
  $ok = ($target === "tray");
  print ($ok ? "PASS" : "FAIL") . " target=" . var_export($target, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
