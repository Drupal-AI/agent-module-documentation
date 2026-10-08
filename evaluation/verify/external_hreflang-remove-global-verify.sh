#!/usr/bin/env bash
# Execution VERIFY: PASS when the de-de toggle External Hreflang alternate is no longer present on
# the global metatag defaults. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $d = \Drupal::entityTypeManager()->getStorage("metatag_defaults")->load("global");
  $v = $d ? (($d->get("tags") ?: [])["hreflang_external"] ?? "") : "";
  $ok = strpos($v, "https://de.exthreflang-toggle.example") === FALSE;
  print (($ok ? "PASS" : "FAIL")) . " value=" . str_replace("\n","\\n",$v) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
