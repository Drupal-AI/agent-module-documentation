#!/usr/bin/env bash
# Enable each project's main module one at a time; stop at the first one that breaks the
# container (bootstrap no longer Successful). Prints the culprit. Runs inside the container.
cd /var/www/html || exit 1
CONTRIB=web/modules/contrib
main_module() {
  local dir="$CONTRIB/$1" f
  [ -d "$dir" ] || return 1
  [ -f "$dir/$1.info.yml" ] && { echo "$1"; return 0; }
  for f in "$dir"/*.info.yml; do [ -e "$f" ] && { basename "$f" .info.yml; return 0; }; done
  return 1
}
while read -r p; do
  [ -z "$p" ] && continue
  m=$(main_module "$p") || { echo "skip $p (not on disk)"; continue; }
  drush pm:list --status=enabled --field=name 2>/dev/null | grep -qx "$m" && continue
  drush en "$m" -y >/dev/null 2>&1
  bs=$(drush status --field=bootstrap 2>/dev/null | head -1 | tr -d ' ')
  if [ "$bs" != "Successful" ]; then
    echo "CULPRIT: $p (module $m) — bootstrap now: '${bs:-BROKEN}'"
    exit 0
  fi
done < agent-module-documentation/.wave.txt
echo "ALL ENABLED CLEANLY — no single-module culprit"
