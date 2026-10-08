#!/usr/bin/env bash
# Execution VERIFY (purge_purger_http): PASS when at least one httppurgersettings config entity
# targets hostname pph-task.example.internal with request_method PURGE and invalidationtype tag.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $cf = \Drupal::configFactory();
  $hit = "none";
  foreach ($cf->listAll("purge_purger_http.settings.") as $name) {
    $c = $cf->get($name);
    if ($c->get("hostname") === "pph-task.example.internal"
        && $c->get("request_method") === "PURGE"
        && $c->get("invalidationtype") === "tag") {
      $hit = $name; break;
    }
  }
  $ok = ($hit !== "none");
  print ($ok ? "PASS" : "FAIL") . " match=" . $hit . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
