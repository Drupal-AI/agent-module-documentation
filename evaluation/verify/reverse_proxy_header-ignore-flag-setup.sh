#!/usr/bin/env bash
# Introspection SETUP: write a marker-guarded block setting the header to HTTP_X_RPH_IGNORE_HEADER
# and reverse_proxy_header_trusted_addresses_ignore = TRUE. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
S="web/sites/default/settings.php"
python3 - "$S" <<'PY'
import re,sys
p=sys.argv[1]; s=open(p).read()
s=re.sub(r"\n*// >>> rph-eval >>>.*?// <<< rph-eval <<<\n*", "\n", s, flags=re.S)
block=("\n\n// >>> rph-eval >>>\n"
       "$settings['reverse_proxy_header'] = 'HTTP_X_RPH_IGNORE_HEADER';\n"
       "$settings['reverse_proxy_header_trusted_addresses_ignore'] = TRUE;\n"
       "// <<< rph-eval <<<\n")
open(p,'w').write(s.rstrip()+block)
PY
drush cr >/dev/null 2>&1
echo "setup: reverse_proxy_header_trusted_addresses_ignore = TRUE in settings.php"
