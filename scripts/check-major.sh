#!/usr/bin/env bash
# Audit: is a higher MAJOR release available than the one Composer installed?
#
# `composer require drupal/x` resolves to the highest *stable* release, which can be an
# older, Drupal-9-only major when the Drupal-11-compatible release is a beta/alpha of a
# higher major (this happened with media_directories: stable 2.0.2 is ^8.8.3||^9, while
# 3.0.0-beta1 is ^10.2||^11||^12). The spec wants the latest major that supports D11, so
# flag every project where a higher major exists and let the caller try to upgrade it.
#
# Usage (inside the DDEV web container, cwd = /var/www/html):
#   scripts/check-major.sh --file wave.txt
#
# Prints one line per project needing attention:
#   <project>\t<installed>\t<higher majors available>\t<installed core_version_requirement>
set -uo pipefail
cd /var/www/html
CONTRIB=web/modules/contrib

projects=()
if [ "${1:-}" = "--file" ]; then
  while read -r n; do [ -n "$n" ] && projects+=("$n"); done < "$2"
else
  projects=("$@")
fi

for p in "${projects[@]}"; do
  inst=$(composer show "drupal/$p" --format=json 2>/dev/null \
          | php -r '$j=json_decode(stream_get_contents(STDIN),true); echo $j["versions"][0] ?? "";')
  [ -n "$inst" ] || continue
  imaj=$(echo "${inst#v}" | cut -d. -f1)
  [ -n "$imaj" ] || continue

  higher=$(composer show -a "drupal/$p" --format=json 2>/dev/null | php -r '
    $j=json_decode(stream_get_contents(STDIN),true);
    $imaj=(int)$argv[1]; $out=[];
    foreach ($j["versions"] ?? [] as $v) {
      if (!preg_match("/^v?(\d+)\./", $v, $m)) continue;
      if ((int)$m[1] > $imaj) $out[(int)$m[1]] = TRUE;
    }
    ksort($out); echo implode(",", array_keys($out));
  ' "$imaj")
  [ -n "$higher" ] || continue

  # core_version_requirement of what is actually on disk
  cvr=""
  for f in "$CONTRIB/$p"/*.info.yml; do
    [ -e "$f" ] || continue
    cvr=$(grep -m1 '^core_version_requirement:' "$f" | sed 's/core_version_requirement:[[:space:]]*//')
    break
  done
  printf '%s\t%s\tmajors:%s\t%s\n' "$p" "$inst" "$higher" "${cvr:-?}"
done
