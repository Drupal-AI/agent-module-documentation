#!/usr/bin/env bash
# Execution VERIFY: PASS when field_fe_link is encrypted with ONLY the uri property
# (encrypt===TRUE and properties===['uri'], not 'title'). Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  $fs = FieldStorageConfig::loadByName("node","field_fe_link");
  $enc = $fs ? (bool) $fs->getThirdPartySetting("field_encrypt","encrypt",FALSE) : FALSE;
  $props = $fs ? array_values($fs->getThirdPartySetting("field_encrypt","properties",[])) : [];
  sort($props);
  $ok = ($enc === TRUE && $props === ["uri"]);
  print (($ok) ? "PASS" : "FAIL") . " encrypt=" . var_export($enc,TRUE) . " properties=[" . implode(",",$props) . "]\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
