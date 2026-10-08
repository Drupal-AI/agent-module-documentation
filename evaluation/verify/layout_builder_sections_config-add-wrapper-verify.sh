#!/usr/bin/env bash
# Execution VERIFY: PASS when title_wrappers offers a 'div' wrapper option (a line whose key is
# 'div'). Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $s = (string) \Drupal::config("layout_builder_sections_config.settings")->get("title_wrappers");
  $ok = FALSE;
  foreach (preg_split("/\r\n|\r|\n/", $s) as $line) {
    $p = explode("|", $line);
    if (count($p) >= 2 && strtolower(trim($p[0])) === "div") { $ok = TRUE; }
  }
  print ($ok ? "PASS" : "FAIL") . " title_wrappers=" . json_encode($s) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
