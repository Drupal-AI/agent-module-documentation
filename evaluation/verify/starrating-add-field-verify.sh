#!/usr/bin/env bash
# Execution VERIFY: PASS when Article has a field named field_srt_task of type 'starrating' with
# max_value === 5. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  $fc = FieldConfig::loadByName("node","article","field_srt_task");
  if (!$fc) { print "FAIL no-field\n"; return; }
  $ok = ($fc->getType() === "starrating" && (int) $fc->getSetting("max_value") === 5);
  print (($ok) ? "PASS" : "FAIL") . " type=" . $fc->getType() . " max=" . var_export($fc->getSetting("max_value"), TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
