#!/usr/bin/env bash
# Live-state verification for the "enable OR on the existing vcfo_eval_toggle view" task.
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# PASS only if the `vcfo_eval_toggle` view still has its two contextual filters AND its
# default display's query.options.contextual_filters_or is now === TRUE.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $v = \Drupal\views\Entity\View::load("vcfo_eval_toggle");
  if (!$v) { print "FAIL view_exists=0\n"; return; }
  $disp = $v->get("display");
  $do = $disp["default"]["display_options"] ?? [];
  $or_on = !empty($do["query"]["options"]["contextual_filters_or"]);
  $arg_count = (!empty($do["arguments"]) && is_array($do["arguments"])) ? count($do["arguments"]) : 0;
  $ok = $or_on && $arg_count >= 2;
  print ($ok ? "PASS" : "FAIL")
    . " view_exists=1"
    . " contextual_filters_or=" . ($or_on ? 1 : 0)
    . " arguments=" . $arg_count . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
