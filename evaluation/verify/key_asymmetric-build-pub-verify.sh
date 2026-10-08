#!/usr/bin/env bash
# Execution VERIFY: PASS when a Key entity ka_task_pub exists, is of type asymmetric_public, has a
# non-empty value, and its key_type_settings.private_key references ka_task_priv2. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\key\Entity\Key;
  $k = Key::load("ka_task_pub");
  if (!$k) { print "FAIL no-key\n"; return; }
  $type = $k->getKeyType()->getPluginId();
  $settings = $k->getKeyType()->getConfiguration();
  $ref = $settings["private_key"] ?? "";
  $len = strlen((string) $k->getKeyValue());
  $ok = ($type === "asymmetric_public") && ($len > 0) && ($ref === "ka_task_priv2");
  print ($ok ? "PASS" : "FAIL") . " type=" . $type . " val_len=" . $len . " private_key=" . ($ref !== "" ? $ref : "(none)") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
