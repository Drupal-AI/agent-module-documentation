#!/usr/bin/env bash
# Execution VERIFY: PASS when a new EPT module was scaffolded at
# web/modules/custom/ept_test_hero with an info.yml that depends on ept_core. exit 0/1.
set -uo pipefail
cd /var/www/html
info="web/modules/custom/ept_test_hero/ept_test_hero.info.yml"
if [ -f "$info" ] && grep -q "ept_core" "$info"; then
  echo "PASS info=$info depends_on_ept_core=yes"
  exit 0
fi
echo "FAIL info_present=$( [ -f "$info" ] && echo yes || echo no )"
exit 1
