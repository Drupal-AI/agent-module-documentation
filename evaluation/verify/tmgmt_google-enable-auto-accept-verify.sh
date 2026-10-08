#!/usr/bin/env bash
# Execution VERIFY: PASS when tmgg_autotask settings.auto_accept === true. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\tmgmt\Entity\Translator;
  $t = Translator::load("tmgg_autotask");
  $v = $t ? $t->getSetting("auto_accept") : NULL;
  $ok = ($v === TRUE || $v === 1 || $v === "1");
  print ($ok ? "PASS" : "FAIL") . " auto_accept=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
