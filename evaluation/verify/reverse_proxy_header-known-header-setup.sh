#!/usr/bin/env bash
# Introspection SETUP: write a marker-guarded block into settings.php setting
# $settings['reverse_proxy_header'] = 'HTTP_X_RPH_KNOWN_HEADER' so an inspecting agent can read
# it back via Settings::get. Idempotent (re-writes the block). Exit 0.
set -uo pipefail
cd /var/www/html
S="web/sites/default/settings.php"
python3 - "$S" <<'PY'
import re,sys
p=sys.argv[1]; s=open(p).read()
s=re.sub(r"\n*// >>> rph-eval >>>.*?// <<< rph-eval <<<\n*", "\n", s, flags=re.S)
s=s.rstrip()+"\n\n// >>> rph-eval >>>\n$settings['reverse_proxy_header'] = 'HTTP_X_RPH_KNOWN_HEADER';\n// <<< rph-eval <<<\n"
open(p,'w').write(s)
PY
drush cr >/dev/null 2>&1
echo "setup: reverse_proxy_header = HTTP_X_RPH_KNOWN_HEADER in settings.php"
