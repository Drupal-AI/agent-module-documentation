#!/usr/bin/env bash
# Execution VERIFY: PASS when max_file_embed_size resolves to 2 MB (2097152 bytes), tolerant of
# the exact string form ("2 MB", "2097152", etc.). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\Component\Utility\Bytes;
  $v = \Drupal::config("markdownify_file_attachment.settings")->get("max_file_embed_size");
  $n = Bytes::toNumber((string) $v);
  $ok = ((int) $n === 2097152);
  print (($ok) ? "PASS" : "FAIL") . " value=" . var_export($v, TRUE) . " bytes=" . $n . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
