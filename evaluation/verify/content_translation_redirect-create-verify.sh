#!/usr/bin/env bash
# Execution VERIFY: PASS when a content_translation_redirect for node/article exists with status
# code 301 and mode 'all'. Reads via the entity storage handler.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $r = \Drupal::entityTypeManager()->getStorage("content_translation_redirect")->load("node__article");
  $code = $r ? $r->getStatusCode() : NULL;
  $mode = $r ? $r->getTranslationMode() : NULL;
  $ok = ($r !== NULL) && ($code === 301) && ($mode === "all");
  print ($ok ? "PASS" : "FAIL") . " exists=" . ($r?"yes":"no") . " code=" . var_export($code,true) . " mode=" . var_export($mode,true) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
