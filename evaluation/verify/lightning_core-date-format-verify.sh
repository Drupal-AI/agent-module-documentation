#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# Live-state verification for "recreate the Long (12-hour) date format Lightning Core ships".
# PASS (exit 0) when the core.date_format.long_12h config entity exists with the shipped
# pattern 'F j, Y \a\t g:i A'. The expected PHP literal is single-quoted (via '\'') so the
# '\a\t' escape stays literal (no TAB). Prints PASS/FAIL with detail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ok = FALSE; $detail = " missing";
  $expected = '\''F j, Y \a\t g:i A'\'';
  if ($df = \Drupal::entityTypeManager()->getStorage("date_format")->load("long_12h")) {
    $pattern = $df->getPattern();
    $detail = " pattern=\"" . $pattern . "\"";
    if ($pattern === $expected) { $ok = TRUE; }
  }
  print ($ok ? "PASS" : "FAIL") . $detail . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
