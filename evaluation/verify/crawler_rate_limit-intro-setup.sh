#!/usr/bin/env bash
# Introspection SETUP (crawler_rate_limit): write a known $settings['crawler_rate_limit.settings']
# block (enabled, apcu backend, bot_traffic requests=137, regular_traffic requests=242) into
# settings.php inside a delimited, php -l-guarded block. An inspecting agent reads it back via
# RateLimitManager::getSettings(). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
S="web/sites/default/settings.php"
python3 - "$S" <<'PY'
import sys, re
path = sys.argv[1]
BEGIN = "# >>> crawler_rate_limit-eval BEGIN"
END   = "# <<< crawler_rate_limit-eval END"
block = (BEGIN + "\n"
 "$settings['crawler_rate_limit.settings']['enabled'] = TRUE;\n"
 "$settings['crawler_rate_limit.settings']['backend'] = 'apcu';\n"
 "$settings['crawler_rate_limit.settings']['bot_traffic'] = ['interval' => 600, 'requests' => 137];\n"
 "$settings['crawler_rate_limit.settings']['regular_traffic'] = ['interval' => 600, 'requests' => 242];\n"
 + END + "\n")
src = open(path).read()
src = re.sub(re.escape(BEGIN)+r".*?"+re.escape(END)+r"\n?", "", src, flags=re.S)
if not src.endswith("\n"): src += "\n"
src += block
open(path + ".crltmp", "w").write(src)
PY
if php -l "$S.crltmp" >/dev/null 2>&1; then
  mv "$S.crltmp" "$S"
  echo "setup: crawler_rate_limit settings written (bot requests=137, regular requests=242, backend=apcu, enabled)"
else
  rm -f "$S.crltmp"
  echo "setup: ABORTED (php -l failed), settings.php unchanged" >&2
  exit 1
fi
