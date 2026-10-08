#!/usr/bin/env bash
# Execution VERIFY: PASS when dblog_filter excludes the 'php' channel's debug-level (and lower)
# messages from the database log: method=exclude AND a log_values row whose channel is 'php'
# and whose level list includes 'debug'. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("dblog_filter.settings");
  $m = $c->get("method"); $rows = $c->get("log_values") ?: [];
  $ok = FALSE;
  foreach ($rows as $row) {
    $p = explode("|", $row);
    if (($p[0] ?? "") === "php" && isset($p[1])) {
      $levels = array_map("trim", explode(",", $p[1]));
      if (in_array("debug", $levels, TRUE)) { $ok = TRUE; }
    }
  }
  $ok = $ok && ($m === "exclude");
  print ($ok ? "PASS" : "FAIL") . " method=" . var_export($m, TRUE) . " log_values=" . json_encode($rows) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
