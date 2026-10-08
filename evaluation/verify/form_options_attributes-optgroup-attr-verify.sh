#!/usr/bin/env bash
# Live-state verification for the form_options_attributes optgroup-select execution case.
# Contract: the agent writes /var/www/html/web/sites/default/files/foa_eval_group.php
# which `return`s a #type=select render array with two <optgroup>s — "German"
# (options audi, bmw) and "Japanese" (option honda) — where the `bmw` <option> under
# German carries data-lux="yes", set via the NESTED #options_attributes structure
# (#options_attributes['German']['bmw']). Renders and checks the rendered HTML.
# FAILs on empty state or if the nested keying is wrong (attribute won't appear).
# Prints PASS/FAIL with detail; exits 0 (pass) / 1 (fail). No arguments.
set -uo pipefail
cd /var/www/html
TARGET="/var/www/html/web/sites/default/files/foa_eval_group.php"

if [ ! -f "$TARGET" ]; then
  echo "FAIL file_missing=$TARGET"
  exit 1
fi

out=$(drush php:eval '
  $f = "'"$TARGET"'";
  $build = @include $f;
  if (!is_array($build)) { print "FAIL not_a_render_array\n"; return; }
  $html = (string) \Drupal::service("renderer")->renderInIsolation($build);
  $grp = (stripos($html, "<optgroup") !== FALSE);
  $ok  = $grp && (bool) preg_match("#<option value=\"bmw\"[^>]*data-lux=\"yes\"#", $html);
  print ($ok ? "PASS" : "FAIL") . " has_optgroup=" . ($grp ? 1 : 0) . " attr_on_bmw=" . ($ok ? 1 : 0) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
