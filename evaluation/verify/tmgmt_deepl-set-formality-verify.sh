#!/usr/bin/env bash
# Execution VERIFY: PASS when translator tdeepl_ftask has formality set to a formal option
# (more or prefer_more). Read-only. Prints PASS/FAIL. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\tmgmt\Entity\Translator;
  $t = Translator::load("tdeepl_ftask");
  $f = $t ? $t->getSetting("formality") : "none";
  $ok = ($t && in_array($f, ["more", "prefer_more"], TRUE));
  print ($ok ? "PASS" : "FAIL") . " formality=" . var_export($f, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
