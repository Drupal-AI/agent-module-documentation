#!/usr/bin/env bash
# Return the site to the clean per-wave baseline: no contrib modules, fresh database.
#
# WHY THIS EXISTS
# Waves 1-51 installed cumulatively. By wave 52 the root had 2,311 requirements and new
# modules could no longer resolve against it — wave 54 attempted 10 projects that all had a
# verified Drupal 11 release and installed **zero** of them, every failure a version clash
# with something an earlier wave had pinned (symfony_mailer_queue needs symfony_mailer
# ^1.4/^1.5 vs a pinned ^2.0; aos needs animate_on_scroll ^1|^2 vs a pinned ^3.0). The fix is
# to stop accumulating: install only what the wave needs, document it, then reset.
#
# WHAT IT DOES
#   1. composer.json require -> core + scaffolding only (the BASELINE list below)
#   2. composer update        -> deletes every contrib module from web/modules/contrib
#   3. database               -> restored from the `base-minimal` ddev snapshot, or
#                                reinstalled with drush site:install if --site-install
#
# RECOVERY
# The pre-reset composer.json/composer.lock of the original cumulative site are kept in
# .campaign-backups/. `cp .campaign-backups/composer.lock.pre-reset composer.lock &&
# composer install` puts all ~2,300 modules back.
#
# Usage (from the repo root, host):
#   scripts/wave-reset.sh                 # snapshot restore (fast, preferred)
#   scripts/wave-reset.sh --site-install   # drush site:install instead
#   scripts/wave-reset.sh --dry-run
set -uo pipefail
cd "$(dirname "$0")/../.."   # project root (contains composer.json + .ddev)

BASELINE='composer/installers drupal/core-composer-scaffold drupal/core-project-message drupal/core-recipe-unpack drupal/core-recommended'
SNAPSHOT="${WAVE_RESET_SNAPSHOT:-base-minimal}"
MODE=snapshot
DRY=

for a in "$@"; do
  case "$a" in
    --site-install) MODE=site-install ;;
    --no-db)        MODE=no-db ;;
    --dry-run)      DRY=1 ;;
    *) echo "unknown option: $a" >&2; exit 1 ;;
  esac
done

# --no-db (or env SKIP_DB_RESET=1): composer-only reset. On this host `ddev snapshot restore`
# — like any DDEV op that RECREATES containers — reliably races into a container-name
# conflict (rebuild → recreate → "name already in use"), leaving DDEV wedged. Documentation
# and static security scanning only need the module CODE on disk (composer require) — modules
# are never enabled — so the DB reset is unnecessary. Skipping it sidesteps the DDEV bug
# entirely: composer runs via `ddev exec` INSIDE the existing web container, no recreate.
[ "${SKIP_DB_RESET:-0}" = "1" ] && MODE=no-db

[ -f composer.json ] || { echo "no composer.json here ($PWD)" >&2; exit 1; }

echo "== 1/3 reducing composer.json to baseline"
if [ -n "$DRY" ]; then
  python3 - "$BASELINE" <<'PY'
import json, sys
keep = set(sys.argv[1].split())
req = json.load(open('composer.json'))['require']
print("  would keep:", sorted(k for k in req if k in keep))
print("  would drop:", len([k for k in req if k not in keep]), "packages")
PY
else
  python3 - "$BASELINE" <<'PY'
import json, collections, sys
keep = sys.argv[1].split()
d = json.load(open('composer.json'), object_pairs_hook=collections.OrderedDict)
d['require'] = collections.OrderedDict((k, d['require'][k]) for k in keep if k in d['require'])
json.dump(d, open('composer.json', 'w'), indent=4)
open('composer.json', 'a').write('\n')
print("  requires now:", len(d['require']))
PY
fi

echo "== 1b/3 ensuring installer plugins stay allowed"
# Several module families ship their own composer plugin and refuse to install when it is
# not in config.allow-plugins (varbase/localgov -> vardot/varbase-patches, drupalauth4ssp ->
# simplesamlphp/composer-module-installer, plus the common patching and installer-path
# plugins). Composer reverts composer.json wholesale when a require fails, so an allowance
# added mid-wave gets rolled back - keep them here, where every reset re-establishes them.
if [ -z "$DRY" ]; then
  for plugin in \
    cweagans/composer-patches \
    oomphinc/composer-installers-extender \
    vardot/varbase-patches \
    simplesamlphp/composer-module-installer \
    simplesamlphp/composer-xmlprovider-installer; do
    ddev exec "cd /var/www/html && composer config allow-plugins.$plugin true" >/dev/null 2>&1
  done
  echo "  allowed: patches, installers-extender, varbase-patches, simplesamlphp"
fi

echo "== 2/3 composer update (removes contrib from web/modules/contrib)"
if [ -n "$DRY" ]; then
  echo "  (dry run) ddev exec composer update"
else
  ddev exec 'cd /var/www/html && composer update --no-interaction --no-progress' 2>&1 | tail -5
fi

echo "== 3/3 resetting the database"
if [ -n "$DRY" ]; then
  echo "  (dry run) mode=$MODE snapshot=$SNAPSHOT"
elif [ "$MODE" = no-db ]; then
  echo "  skipped (--no-db): modules are never enabled for doc/scan, so the DB is irrelevant;"
  echo "  avoids the ddev container-recreate conflict that snapshot restore triggers on this host."
elif [ "$MODE" = snapshot ]; then
  # A snapshot restore is ~30s vs several minutes for site:install, and gives an identical
  # starting point every wave. Note: restoring straight after a crashed DB container can
  # silently no-op — always verify the table count afterwards, as below.
  ddev snapshot restore "$SNAPSHOT" 2>&1 | tail -2
else
  ddev exec 'cd /var/www/html && drush site:install -y' 2>&1 | tail -3
fi

if [ -z "$DRY" ]; then
  echo "== verify"
  ddev exec 'cd /var/www/html && drush status --fields=bootstrap,db-status 2>&1 | head -3'
  echo -n "  enabled modules: "
  ddev exec 'cd /var/www/html && drush pm:list --status=enabled --field=name 2>/dev/null | wc -l'
  echo -n "  contrib dirs:    "
  ls web/modules/contrib 2>/dev/null | wc -l
fi
