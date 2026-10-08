#!/usr/bin/env bash
# Execution RESET: remove any rph-eval block and reverse_proxy_header assignments so both the
# header and the ignore flag are unset and verify FAILS until the agent sets them. Exit 0.
set -uo pipefail
cd /var/www/html
S="web/sites/default/settings.php"
python3 - "$S" <<'PY'
import re,sys
p=sys.argv[1]; s=open(p).read()
s=re.sub(r"\n*// >>> rph-eval >>>.*?// <<< rph-eval <<<\n*", "\n", s, flags=re.S)
lines=[l for l in s.splitlines(keepends=True)
       if not re.match(r"\s*\$settings\['reverse_proxy_header(_trusted_addresses_ignore)?'\]\s*=", l)]
open(p,'w').write("".join(lines))
PY
drush cr >/dev/null 2>&1
echo "reset: no reverse_proxy_header / ignore flag configured"
