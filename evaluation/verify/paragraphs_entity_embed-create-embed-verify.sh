#!/usr/bin/env bash
# Execution VERIFY: PASS when an embedded_paragraphs entity labelled 'PEE Hard Embed' exists and
# references at least one paragraph. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("embedded_paragraphs");
  $found = $storage->loadByProperties(["label" => "PEE Hard Embed"]);
  $e = $found ? reset($found) : NULL;
  $paras = $e ? count($e->getParagraph()) : 0;
  $ok = ($e && $paras >= 1);
  print ($ok ? "PASS" : "FAIL") . " entity=" . ($e ? $e->id() : "none") . " paragraphs=" . $paras . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
