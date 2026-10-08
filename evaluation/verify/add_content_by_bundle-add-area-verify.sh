#!/usr/bin/env bash
# Execution VERIFY: PASS when view acbb_task has an add_content_by_bundle handler in the
# default display footer, targeting entity type "node" and bundle "page".
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\views\Entity\View;
  $v = View::load("acbb_task");
  $c = $v ? ($v->getDisplay("default")["display_options"]["footer"]["add_content_by_bundle"] ?? NULL) : NULL;
  $type = is_array($c) ? ($c["type"] ?? "") : "";
  $bundle = is_array($c) ? (is_array($c["bundle"] ?? NULL) ? reset($c["bundle"]) : ($c["bundle"] ?? "")) : "";
  $ok = ($c !== NULL && $type === "node" && $bundle === "page");
  print ($ok ? "PASS" : "FAIL") . " handler=" . (is_array($c) ? "yes" : "no") . " type=" . $type . " bundle=" . $bundle . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
