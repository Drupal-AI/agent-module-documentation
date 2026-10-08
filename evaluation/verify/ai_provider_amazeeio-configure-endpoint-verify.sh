#!/usr/bin/env bash
# HARD (execution) verify: the agent must repoint the amazee.ai provider at the self-hosted
# gateway https://litellm.acme.example/v1 and enable moderation, in ai_provider_amazeeio.settings.
# Config-only check (no amazee.ai API call). Prints PASS/FAIL and exits 0 (pass) / 1 (fail).
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $c = \Drupal::config("ai_provider_amazeeio.settings");
  $host = $c->get("host");
  $mod = $c->get("moderation");
  $host_ok = ($host === "https://litellm.acme.example/v1");
  $mod_ok = ((bool) $mod === TRUE);
  print (($host_ok && $mod_ok) ? "PASS" : "FAIL")
    . " host_ok=" . ($host_ok?1:0) . " mod_ok=" . ($mod_ok?1:0)
    . " host=" . $host . " moderation=" . var_export($mod, TRUE) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
