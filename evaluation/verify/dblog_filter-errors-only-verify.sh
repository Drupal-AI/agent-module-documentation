#!/usr/bin/env bash
# Execution VERIFY: PASS when dblog_filter is configured to log ONLY error-and-above to the
# database log: method=include, severities error/critical/alert/emergency=true and
# warning/notice/info/debug=false. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("dblog_filter.settings");
  $m = $c->get("method"); $s = $c->get("severity_levels") ?: [];
  $ok = ($m === "include")
    && !empty($s["error"]) && !empty($s["critical"]) && !empty($s["alert"]) && !empty($s["emergency"])
    && empty($s["warning"]) && empty($s["notice"]) && empty($s["info"]) && empty($s["debug"]);
  print ($ok ? "PASS" : "FAIL") . " method=" . var_export($m, TRUE) . " sev=" . json_encode($s) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
