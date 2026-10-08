#!/usr/bin/env bash
# Execution VERIFY: PASS when the Key referenced by jwt.config->key_id is a jwt_hs key whose
# algorithm is HS512 (i.e. JWT now signs with HS512). Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\key\Entity\Key;
  $kid = \Drupal::config("jwt.config")->get("key_id");
  $key = $kid ? Key::load($kid) : NULL;
  $alg = $key ? ($key->getKeyType()->getConfiguration()["algorithm"] ?? "none") : "none";
  $type = $key ? $key->getKeyType()->getPluginId() : "none";
  $ok = ($key && $type === "jwt_hs" && $alg === "HS512");
  print ($ok ? "PASS" : "FAIL") . " key_id=" . var_export($kid, TRUE) . " type=" . $type . " alg=" . $alg . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
