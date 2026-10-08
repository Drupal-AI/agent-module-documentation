#!/usr/bin/env bash
# Execution VERIFY: PASS when jwt.config->key_id names an existing jwt_hs Key (i.e. the site can
# now sign HMAC JWTs). Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\key\Entity\Key;
  $kid = \Drupal::config("jwt.config")->get("key_id");
  $key = $kid ? Key::load($kid) : NULL;
  $type = $key ? $key->getKeyType()->getPluginId() : "none";
  $ok = ($key && $type === "jwt_hs");
  print ($ok ? "PASS" : "FAIL") . " key_id=" . var_export($kid, TRUE) . " type=" . $type . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
