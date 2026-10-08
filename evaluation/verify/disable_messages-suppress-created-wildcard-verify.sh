#!/usr/bin/env bash
# Live-state verification for "suppress ALL '... has been created.' messages with a wildcard".
# Prints PASS/FAIL and exits 0 (pass) / 1 (fail). No arguments.
# Mirrors the module's runtime matcher: filtering must be enabled and a compiled regex in
# disable_messages_ignore_regex must match TWO different creation messages, while an update
# message must still slip through (guards against a catch-all and proves the wildcard works).
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $hide1 = "Article Foo has been created.";
  $hide2 = "Basic page Bar has been created.";
  $keep  = "Article Foo has been updated.";
  $cfg = \Drupal::config("disable_messages.settings");
  $enable = (bool) $cfg->get("disable_messages_enable");
  $regexps = $cfg->get("disable_messages_ignore_regex") ?: [];
  $m1 = $m2 = $mk = FALSE;
  foreach ($regexps as $re) {
    if (!is_string($re) || $re === "") { continue; }
    if (@preg_match($re, $hide1) === 1) { $m1 = TRUE; }
    if (@preg_match($re, $hide2) === 1) { $m2 = TRUE; }
    if (@preg_match($re, $keep)  === 1) { $mk = TRUE; }
  }
  $ok = $enable && $m1 && $m2 && !$mk;
  print ($ok ? "PASS" : "FAIL") . " enable=".($enable?1:0)." hides_article=".($m1?1:0)." hides_page=".($m2?1:0)." keeps_update=".($mk?0:1)." patterns=".count($regexps)."\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
