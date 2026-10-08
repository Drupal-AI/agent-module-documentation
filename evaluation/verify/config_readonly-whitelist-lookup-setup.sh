#!/usr/bin/env bash
# Introspection SETUP: install a known config_readonly whitelist into settings.php so an
# inspecting agent can read back which config names/patterns are exempt from the lock.
# NOTE: deliberately does NOT set $settings['config_readonly'] — the site stays writable,
# only the (currently unused) whitelist is populated. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

S=web/sites/default/settings.php
MARK_BEGIN='// BEGIN config_readonly eval whitelist-lookup'
MARK_END='// END config_readonly eval whitelist-lookup'

# Remove any previous block first so re-running is safe.
php -r '
$f = $argv[1];
$s = file_get_contents($f);
$s = preg_replace("#\n?// BEGIN config_readonly eval whitelist-lookup.*?// END config_readonly eval whitelist-lookup\n?#s", "\n", $s);
file_put_contents($f, $s);
' "$S"

cat >> "$S" <<'PHP'
// BEGIN config_readonly eval whitelist-lookup
$settings['config_readonly_whitelist_patterns'] = [
  'system.maintenance',
  'mymodule.editable_settings',
  'views.view.cr_eval_*',
];
// END config_readonly eval whitelist-lookup
PHP

echo "setup: config_readonly_whitelist_patterns = system.maintenance, mymodule.editable_settings, views.view.cr_eval_*"
