#!/usr/bin/env bash
# Live-state verification for the form_options_attributes flat-select execution case.
# Contract: the agent writes /var/www/html/web/sites/default/files/foa_eval_flat.php
# which `return`s a Drupal render array for a #type=select element whose `premium`
# <option> carries the HTML attribute data-tier="gold", set via #options_attributes.
# This script includes that file, renders it in isolation, and checks the rendered
# HTML. PASS only if the attribute actually lands on the premium <option>.
# FAILs on empty state (no file) or if #options_attributes is used incorrectly.
# Prints PASS/FAIL with detail; exits 0 (pass) / 1 (fail). No arguments.
set -uo pipefail
cd /var/www/html
TARGET="/var/www/html/web/sites/default/files/foa_eval_flat.php"

if [ ! -f "$TARGET" ]; then
  echo "FAIL file_missing=$TARGET"
  exit 1
fi

out=$(drush php:eval '
  $f = "'"$TARGET"'";
  $build = @include $f;
  if (!is_array($build)) { print "FAIL not_a_render_array\n"; return; }
  $html = (string) \Drupal::service("renderer")->renderInIsolation($build);
  // The premium <option> must carry data-tier="gold" (order-independent within the tag).
  $ok = (bool) preg_match("#<option value=\"premium\"[^>]*data-tier=\"gold\"#", $html)
     || (bool) preg_match("#<option value=\"premium\"[^>]*data-tier=.gold.#", $html);
  print ($ok ? "PASS" : "FAIL") . " attr_on_premium=" . ($ok ? 1 : 0) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
