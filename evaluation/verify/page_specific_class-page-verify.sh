#!/usr/bin/env bash
# Execution VERIFY: PASS when a mapping line makes /psc-eval-page get body class psc-eval-class.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = (string) \Drupal::config("page_specific_class.settings")->get("url_with_class");
  $ok = FALSE;
  foreach (preg_split("/\r\n|\r|\n/", $v) as $line) {
    $p = explode("|", $line, 2);
    if (count($p) === 2) {
      $path = trim(strtolower($p[0]));
      $classes = preg_split("/\s+/", trim($p[1]));
      if ($path === "/psc-eval-page" && in_array("psc-eval-class", $classes, TRUE)) { $ok = TRUE; }
    }
  }
  print ($ok ? "PASS" : "FAIL") . " url_with_class=" . json_encode($v) . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
