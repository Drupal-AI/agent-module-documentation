#!/usr/bin/env bash
# Execution VERIFY: PASS when the generator scaffolded an ebt_skprobe module — its info.yml and
# the block_content type config both exist under web/modules/custom/ebt_skprobe. exit 0/1.
set -uo pipefail
cd /var/www/html
info="web/modules/custom/ebt_skprobe/ebt_skprobe.info.yml"
btype="web/modules/custom/ebt_skprobe/config/install/block_content.type.ebt_skprobe.yml"
if [ -f "$info" ] && [ -f "$btype" ]; then
  echo "PASS info+block_content.type present"
  exit 0
else
  echo "FAIL info=$( [ -f "$info" ] && echo yes || echo no ) block_type=$( [ -f "$btype" ] && echo yes || echo no )"
  exit 1
fi
