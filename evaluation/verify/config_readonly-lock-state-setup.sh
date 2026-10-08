#!/usr/bin/env bash
# Introspection SETUP: put a known, *inactive* config_readonly wiring in settings.php.
# The lock flag is set from an environment variable that is not present, so the site stays
# writable while the file genuinely contains a $settings['config_readonly'] assignment.
# The agent must inspect the RUNNING site (not just grep the file) to report that the lock
# is currently OFF / "Config is writable". Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

S=web/sites/default/settings.php

php -r '
$f = $argv[1];
$s = file_get_contents($f);
$s = preg_replace("#\n?// BEGIN config_readonly eval lock-state.*?// END config_readonly eval lock-state\n?#s", "\n", $s);
file_put_contents($f, $s);
' "$S"

cat >> "$S" <<'PHP'
// BEGIN config_readonly eval lock-state
// Conditional lock: only active when CR_EVAL_LOCK=1 is exported for the request.
if (getenv('CR_EVAL_LOCK') === '1') {
  $settings['config_readonly'] = TRUE;
}
// END config_readonly eval lock-state
PHP


state=$(drush php:eval 'print \Drupal\Core\Site\Settings::get("config_readonly") ? "ON" : "OFF";' 2>/dev/null)
echo "setup: conditional config_readonly block installed; current lock state = ${state}"
