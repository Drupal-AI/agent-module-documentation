#!/usr/bin/env bash
# Live-state verification for "suppress the exact message 'The changes have been saved.'".
# Prints PASS/FAIL and exits 0 (pass) / 1 (fail). No arguments.
# Mirrors the module's runtime matcher: filtering must be enabled and at least one compiled
# regex in disable_messages_ignore_regex must match the target message, while an unrelated
# control message must still slip through (guards against a catch-all like /^.*$/).
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $hide = "The changes have been saved.";
  $keep = "Your comment has been posted.";
  $cfg = \Drupal::config("disable_messages.settings");
  $enable = (bool) $cfg->get("disable_messages_enable");
  $regexps = $cfg->get("disable_messages_ignore_regex") ?: [];
  $mhide = FALSE; $mkeep = FALSE;
  foreach ($regexps as $re) {
    if (!is_string($re) || $re === "") { continue; }
    if (@preg_match($re, $hide) === 1) { $mhide = TRUE; }
    if (@preg_match($re, $keep) === 1) { $mkeep = TRUE; }
  }
  $ok = $enable && $mhide && !$mkeep;
  print ($ok ? "PASS" : "FAIL") . " enable=".($enable?1:0)." hides_target=".($mhide?1:0)." keeps_control=".($mkeep?0:1)." patterns=".count($regexps)."\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
