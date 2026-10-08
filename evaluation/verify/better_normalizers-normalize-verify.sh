#!/usr/bin/env bash
# Execution VERIFY: PASS when /tmp/bnrm-eval/file-out.json is hal_json for the file that embeds the
# file's contents as base64 (proof better_normalizers' FileEntityNormalizer ran). exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $p = "/tmp/bnrm-eval/file-out.json";
  if (!is_file($p)) { print "FAIL no-output-file\n"; return; }
  $json = file_get_contents($p);
  $needle = base64_encode("BNRM-EVAL-CONTENT-42");
  $ok = (strpos($json, $needle) !== false) && (strpos($json, "\"data\"") !== false);
  print ($ok ? "PASS" : "FAIL") . " has_base64_data=" . var_export($ok, TRUE) . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
