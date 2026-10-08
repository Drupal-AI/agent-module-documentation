#!/usr/bin/env bash
# PASS when the handy bundle tag for hct_vocab terms has been invalidated (row present).
set -uo pipefail
cd /var/www/html
n=$(drush sqlq "SELECT COUNT(*) FROM cachetags WHERE tag='handy_cache_tags:taxonomy_term:hct_vocab'" 2>/dev/null | tr -dc '0-9')
if [ "${n:-0}" -ge 1 ]; then echo "PASS rows=$n"; exit 0; else echo "FAIL rows=${n:-0}"; exit 1; fi
