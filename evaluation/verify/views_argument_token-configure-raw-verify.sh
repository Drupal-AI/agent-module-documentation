#!/usr/bin/env bash
# Execution VERIFY: PASS when vat_rawtask's nid contextual filter uses the views_argument_token
# "token" default_argument_type, with a [node:field_tags] token and RAW field values on
# (process == 1). Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\views\Entity\View;
  $v = View::load("vat_rawtask");
  $arg = $v ? ($v->get("display")["default"]["display_options"]["arguments"]["nid"] ?? NULL) : NULL;
  $type = $arg["default_argument_type"] ?? "none";
  $opts = $arg["default_argument_options"] ?? [];
  $tok = $opts["argument"] ?? "";
  $proc = $opts["process"] ?? NULL;
  $ok = ($type === "token" && strpos((string) $tok, "node:field_tags") !== FALSE && (int) $proc === 1);
  print ($ok ? "PASS" : "FAIL") . " type=" . $type . " argument=" . $tok . " process=" . var_export($proc, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
