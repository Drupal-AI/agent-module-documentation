#!/usr/bin/env bash
# Walk the popularity-sorted, D10-or-newer (⊇ D11) module feed and collect the first
# TARGET machine names that are NOT already documented or skip-listed.
# Output: TAB-separated  machine_name <tab> composer_namespace <tab> active_installs
# Run inside the DDEV web container:  ddev exec bash agent-module-documentation/scripts/build-d10-list.sh
set -uo pipefail
cd "$(dirname "$0")/.."                       # -> agent-module-documentation/
DEDUP="scripts/.dedup-all.txt"
OUT="scripts/.campaign-d10-5000.txt"
TARGET="${1:-5000}"
LIMIT=50
MAXPAGE="${2:-600}"                           # hard safety cap on pages walked
BASE='https://www.drupal.org/jsonapi/node/project_module'
QS="sort=-field_active_installs_total"
QS+="&filter[min][condition][path]=field_core_semver_minimum&filter[min][condition][operator]=%3C%3D&filter[min][condition][value]=10999999"
QS+="&filter[max][condition][path]=field_core_semver_maximum&filter[max][condition][operator]=%3E%3D&filter[max][condition][value]=10000000"
QS+="&filter[status]=1"
QS+="&fields[node--project_module]=field_project_machine_name,field_composer_namespace,field_active_installs_total"
QS+="&page[limit]=${LIMIT}"

: > "$OUT"
new=0
for ((page=0; page<MAXPAGE; page++)); do
  off=$(( page * LIMIT ))
  resp=$(curl -sfLg "${BASE}?${QS}&page[offset]=${off}") || { echo "curl failed at offset $off" >&2; break; }
  # Emit "machine<TAB>namespace<TAB>installs" for this page, filtering dedup in awk.
  page_new=$(printf '%s' "$resp" | php -r '
    $d=json_decode(file_get_contents("php://stdin"),true);
    if(empty($d["data"])){exit(2);}
    foreach($d["data"] as $n){$a=$n["attributes"];
      $m=$a["field_project_machine_name"]??""; if($m==="")continue;
      printf("%s\t%s\t%s\n",$m,$a["field_composer_namespace"]??"",$a["field_active_installs_total"]??0);
    }' )
  rc=$?
  if [ $rc -eq 2 ]; then echo "feed exhausted at offset $off" >&2; break; fi
  # keep only rows whose machine name isn't in the dedup set
  added=$(printf '%s\n' "$page_new" | awk -F'\t' 'NR==FNR{seen[$1]=1;next} $1!="" && !($1 in seen)' "$DEDUP" - | tee -a "$OUT" | wc -l)
  new=$(( new + added ))
  if (( page % 20 == 0 )); then echo "page $page (offset $off): +$added new, total new=$new" >&2; fi
  if (( new >= TARGET )); then echo "reached target $TARGET at page $page" >&2; break; fi
  sleep 0.25
done
# Trim to exactly TARGET and report
head -n "$TARGET" "$OUT" > "$OUT.tmp" && mv "$OUT.tmp" "$OUT"
echo "DONE: wrote $(wc -l < "$OUT") new modules to $OUT" >&2
