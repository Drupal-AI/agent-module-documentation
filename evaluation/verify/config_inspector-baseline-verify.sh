#!/usr/bin/env bash
# Execution VERIFY: PASS when config_inspector-baseline.json exists (in the docroot web/, where
# config:inspect --generate-baseline writes, or the project root) and is valid JSON. 0 pass/1 fail.
set -uo pipefail
for f in /var/www/html/web/config_inspector-baseline.json /var/www/html/config_inspector-baseline.json; do
  if [ -f "$f" ] && php -r 'json_decode(file_get_contents($argv[1])); exit(json_last_error()?1:0);' "$f" 2>/dev/null; then
    echo "PASS baseline present and valid JSON: $f"; exit 0
  fi
done
echo "FAIL baseline file missing or invalid"; exit 1
