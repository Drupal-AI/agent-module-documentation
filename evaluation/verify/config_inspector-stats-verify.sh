#!/usr/bin/env bash
# Execution VERIFY: PASS when /var/www/html/config_inspector_stats.json exists, is valid JSON,
# and contains an 'assessment' section. Exit 0 pass / 1 fail.
set -uo pipefail
f=/var/www/html/config_inspector_stats.json
if [ -f "$f" ] && php -r '$d=json_decode(file_get_contents($argv[1]),true); exit((is_array($d)&&isset($d["assessment"]))?0:1);' "$f" 2>/dev/null; then
  echo "PASS statistics file present, valid JSON, has assessment"; exit 0
fi
echo "FAIL statistics file missing/invalid/no assessment: $f"; exit 1
