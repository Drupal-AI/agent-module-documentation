#!/usr/bin/env bash
# Execution VERIFY: PASS when st_sort now has a "Similar by terms: Similarity" sort using the
# similar_terms_sort handler with sort_method == "weight". Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\views\Entity\View;
  $v = View::load("st_sort");
  $sorts = $v ? ($v->get("display")["default"]["display_options"]["sorts"] ?? []) : [];
  $found = NULL;
  foreach ($sorts as $s) {
    if (($s["plugin_id"] ?? "") === "similar_terms_sort") { $found = $s; break; }
  }
  $method = $found["sort_method"] ?? NULL;
  $ok = ($found !== NULL && $method === "weight");
  print ($ok ? "PASS" : "FAIL") . " handler=" . ($found ? "similar_terms_sort" : "none") . " sort_method=" . var_export($method, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
