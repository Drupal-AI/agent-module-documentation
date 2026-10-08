#!/usr/bin/env bash
# Execution VERIFY: PASS when the MathJax filter (filter_mathjax) is enabled on the text format
# mathjax_task_format AND is the LAST filter in its processing order (highest weight of the
# enabled filters), which is what the module requires. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  $f = FilterFormat::load("mathjax_task_format");
  if (!$f) { print "FAIL format mathjax_task_format missing\n"; return; }
  $filters = $f->filters();
  $enabled = [];
  foreach ($filters as $id => $filter) {
    if ($filter->status) { $enabled[$id] = (int) $filter->weight; }
  }
  $on = array_key_exists("filter_mathjax", $enabled);
  $last = $on && ($enabled["filter_mathjax"] >= max($enabled));
  $ok = $on && $last;
  print ($ok ? "PASS" : "FAIL") . " enabled=" . var_export($on, TRUE)
    . " weights=" . json_encode($enabled) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
