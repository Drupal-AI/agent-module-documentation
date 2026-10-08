#!/usr/bin/env bash
# Execution VERIFY: PASS when st_task now has a "Similar by terms: Nid" contextual filter — an
# argument using the similar_terms_arg handler with min_match_percentage == 50.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\views\Entity\View;
  $v = View::load("st_task");
  $args = $v ? ($v->get("display")["default"]["display_options"]["arguments"] ?? []) : [];
  $found = NULL;
  foreach ($args as $a) {
    if (($a["plugin_id"] ?? "") === "similar_terms_arg") { $found = $a; break; }
  }
  $pct = $found["min_match_percentage"] ?? NULL;
  $ok = ($found !== NULL && (int) $pct === 50);
  print ($ok ? "PASS" : "FAIL") . " handler=" . ($found ? "similar_terms_arg" : "none") . " min_match_percentage=" . var_export($pct, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
