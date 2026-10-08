#!/usr/bin/env bash
# Execution VERIFY: PASS when a Key entity ka_task_priv exists, is of type asymmetric_private, and
# has a non-empty key value. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\key\Entity\Key;
  $k = Key::load("ka_task_priv");
  if (!$k) { print "FAIL no-key\n"; return; }
  $type = $k->getKeyType()->getPluginId();
  $len = strlen((string) $k->getKeyValue());
  $ok = ($type === "asymmetric_private") && ($len > 0);
  print ($ok ? "PASS" : "FAIL") . " type=" . $type . " val_len=" . $len . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
