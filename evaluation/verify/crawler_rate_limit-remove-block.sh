#!/usr/bin/env bash
# Remove the delimited crawler_rate_limit-eval block from settings.php (php -l guarded).
# Used as introspection CLEANUP and execution RESET. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
S="web/sites/default/settings.php"
python3 - "$S" <<'PY'
import sys, re
path = sys.argv[1]
BEGIN = "# >>> crawler_rate_limit-eval BEGIN"
END   = "# <<< crawler_rate_limit-eval END"
src = open(path).read()
src = re.sub(re.escape(BEGIN)+r".*?"+re.escape(END)+r"\n?", "", src, flags=re.S)
open(path + ".crltmp", "w").write(src)
PY
if php -l "$S.crltmp" >/dev/null 2>&1; then
  mv "$S.crltmp" "$S"
  echo "crawler_rate_limit settings block removed (baseline: no crawler settings)"
else
  rm -f "$S.crltmp"
  echo "remove: ABORTED (php -l failed), settings.php unchanged" >&2
  exit 1
fi
