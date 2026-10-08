#!/usr/bin/env bash
# Live-state verification for the "build a view whose contextual filters use OR" task.
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# PASS only if a view `vcfo_eval_build` exists whose default display has:
#   - query.options.contextual_filters_or === TRUE (the module's OR flag), AND
#   - at least TWO contextual filters (arguments) defined.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $v = \Drupal\views\Entity\View::load("vcfo_eval_build");
  if (!$v) { print "FAIL view_exists=0\n"; return; }
  $disp = $v->get("display");
  $ok_or = FALSE; $arg_count = 0;
  foreach ($disp as $d) {
    $do = $d["display_options"] ?? [];
    if (!empty($do["query"]["options"]["contextual_filters_or"])) { $ok_or = TRUE; }
    if (!empty($do["arguments"]) && is_array($do["arguments"])) {
      $arg_count = max($arg_count, count($do["arguments"]));
    }
  }
  $args_ok = $arg_count >= 2;
  $ok = $ok_or && $args_ok;
  print ($ok ? "PASS" : "FAIL")
    . " view_exists=1"
    . " contextual_filters_or=" . ($ok_or ? 1 : 0)
    . " arguments=" . $arg_count . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
