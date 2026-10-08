#!/usr/bin/env bash
# Execution VERIFY: PASS when vat_user's... (vat_task) uid contextual filter now uses the
# views_argument_token "token" default_argument_type with a [current-user:uid] token.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\views\Entity\View;
  $v = View::load("vat_task");
  $arg = $v ? ($v->get("display")["default"]["display_options"]["arguments"]["uid"] ?? NULL) : NULL;
  $type = $arg["default_argument_type"] ?? "none";
  $tok = $arg["default_argument_options"]["argument"] ?? "";
  $ok = ($type === "token" && strpos((string) $tok, "current-user:uid") !== FALSE);
  print ($ok ? "PASS" : "FAIL") . " type=" . $type . " argument=" . $tok . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
