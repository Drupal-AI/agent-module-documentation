#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# Live-state verification for the "client remote pointing at a server URL" task.
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# Loads the `remote` config entity eval_remote and asserts:
#   rm    — remote eval_remote exists
#   url   — its url is exactly https://source.eval.example.com
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $rm = $urlok = FALSE;
  $url = "";
  $r = \Drupal::entityTypeManager()->getStorage("remote")->load("eval_remote");
  if ($r) {
    $rm = TRUE;
    $url = rtrim((string) $r->get("url"), "/");
    $urlok = ($url === "https://source.eval.example.com");
  }
  $pass = $rm && $urlok;
  print ($pass ? "PASS" : "FAIL")
    . " rm=" . ($rm?1:0) . " url=" . $url . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
