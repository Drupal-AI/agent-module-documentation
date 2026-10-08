#!/usr/bin/env bash
# Pollution-safe sequential installer.
#
# `composer require -W` does not reliably revert composer.json when a resolution fails, so a
# single unresolvable module poisons every subsequent require in a batch. This installs one
# module at a time and restores composer.json from a snapshot after any failure, so failures
# are isolated and never block the rest. Modules already on disk are skipped.
#
# Usage (inside the DDEV web container, cwd = /var/www/html):
#   scripts/safe-install.sh --file <list>     (one machine name per line)
# Prints:  <name>\t<version|FAILED|present>
set -uo pipefail
cd /var/www/html

names=()
if [ "${1:-}" = "--file" ]; then
  while read -r n; do [ -n "$n" ] && names+=("$n"); done < "$2"
else
  names=("$@")
fi

# Read the release version from the module's own info.yml rather than asking composer.
# `composer show drupal/X --format=json` is not reliable here: run from a script (no TTY) it
# prefixes its JSON with a notice, so json_decode() returns null and every module reported "?"
# for its version in wave 59. The drupal.org packaging script always writes `version:` into the
# released info.yml, so read that - authoritative, and no subprocess.
version_of() {
  local d="web/modules/contrib/$1" f
  for f in "$d/$1.info.yml" "$d"/*.info.yml "$d"/*/*.info.yml; do
    [ -f "$f" ] || continue
    v=$(sed -n "s/^version: *['\"]\{0,1\}\([^'\"]*\)['\"]\{0,1\} *$/\1/p" "$f" | head -1)
    [ -n "$v" ] && { echo "$v"; return 0; }
  done
  return 1
}

SNAP=$(mktemp)
cp composer.json "$SNAP"

# Per-run failure log. "FAILED" on its own is undiagnosable — the three real causes
# (no D11 release, dependency clash with an already-installed module, transient network
# error) need composer's own output to tell apart, and swallowing it cost a whole wave's
# worth of misdiagnosis. Overridable with FAIL_LOG=/path.
FAIL_LOG="${FAIL_LOG:-/tmp/safe-install-failures.log}"
: > "$FAIL_LOG"

# Restore composer.json if we are interrupted mid-require. Without this an interrupted run
# leaves a stray requirement in composer.json that makes EVERY later require fail with an
# unrelated-looking error.
cleanup() {
  [ -f "$SNAP" ] && cp "$SNAP" composer.json
  rm -f "$SNAP"
  echo "interrupted: composer.json restored from snapshot" >&2
  exit 130
}
trap cleanup INT TERM

for m in "${names[@]}"; do
  if [ -d "web/modules/contrib/$m" ]; then
    printf '%s\tpresent\n' "$m"
    cp composer.json "$SNAP"   # refresh snapshot to the last-good state
    continue
  fi
  err=$(composer require "drupal/$m" -W --no-interaction --no-progress 2>&1)
  rc=$?
  # A drupal.org project can be a **metapackage** that only pulls in the project actually
  # shipping the module, because the module is a submodule of something else:
  # drupal/webform_bootstrap resolves to nothing of its own and lands at
  # web/modules/contrib/webform/modules/webform_bootstrap (wave 84). composer exits 0, the
  # top-level directory never appears, and the old code fell through to the classifier - which
  # matched none of its patterns and reported a bare "other" with an empty log excerpt.
  # Report it as what it is, and say where it landed, so the doc goes under the right parent.
  if [ $rc -eq 0 ] && [ ! -d "web/modules/contrib/$m" ]; then
    sub=$(find web/modules/contrib -mindepth 3 -maxdepth 4 -type d -name "$m" 2>/dev/null | head -1)
    if [ -n "$sub" ]; then
      printf '%s\tsubmodule-of\t%s\n' "$m" "${sub#web/modules/contrib/}"
      cp composer.json "$SNAP"
      continue
    fi
  fi
  if [ $rc -eq 0 ] && [ -d "web/modules/contrib/$m" ]; then
    v=$(version_of "$m")
    # A missing `version:` in the info.yml means drupal.org's packaging script never ran, i.e.
    # composer resolved to a dev branch and cloned from git rather than taking a release. Say so:
    # the module is documentable but is not a released artefact, and it leaves a .git directory
    # on disk (smart_read_more_link, wave 66).
    if [ -z "$v" ] && [ -d "web/modules/contrib/$m/.git" ]; then
      v="DEV-CHECKOUT"
    fi
    printf '%s\t%s\n' "$m" "${v:-?}"
    cp composer.json "$SNAP"   # commit: this module stuck, make it the new baseline
  else
    # Classify from composer's output so the report is actionable.
    # Order matters: the most specific/actionable cause wins. A single composer error can
    # mention several of these (e.g. a transient curl timeout alongside a real conflict).
    reason=other
    case "$err" in
      *"Could not find package"*)                          reason=not-on-packages-server ;;
      *"conflicts with your root composer.json require"*)  reason=dependency-clash ;;
      # A PHP extension the module's dependency chain needs is not built into the container
      # (oidc -> sop/crypto-types -> ext-gmp, wave 71). Fixable locally by adding the
      # extension to the web image, so it must not be confused with a dead module.
      *"is missing from your system"*)                     reason=missing-php-extension ;;
      # MUST come before the advisory case. When a module has no release for the running
      # core, composer says "require drupal/core ^8 || ^9 -> found drupal/core[...] but these
      # were not loaded, because they are affected by security advisories" — the advisories
      # are on the OLD CORE it wants, not on the module. Matching the advisory text first
      # misreported seven dead modules as advisory-blocked in wave 71. Note the verb in that
      # sentence is "require" (plural subject), not "requires": the original pattern only had
      # the singular form, so it never matched and every such case fell through.
      *"require drupal/core"*|*"requires drupal/core"*)    reason=no-d11-release ;;
      # phpspreadsheet/guzzle/etc. with an unpatched advisory are refused by
      # policy.advisories.block - the module is fine, its dependency is not.
      *"affected by security advisories"*)                 reason=blocked-by-advisory ;;
      # MUST come before the network case. A require KEY that concatenates the package name
      # with its constraint ("drupal/flag ^4.0@beta || ^5.0": "*", flag_lists 4.0.4) makes
      # composer build a metadata URL containing spaces and pipes, and curl rejects it with
      # error 3 "Malformed input to a URL function". That reads as a network blip and is not
      # one: it is deterministic, permanent until upstream fixes the typo, and it names the
      # DEPENDENCY (drupal/flag) rather than the module that has the bad manifest — so
      # retrying, or blaming the named package, both waste time. Retry pinned to the previous
      # release instead; only the one bad release is affected.
      *"Malformed input to a URL"*|*"URL rejected"*)       reason=broken-manifest ;;
      *"curl error"*|*"Connection timed out"*|*"could not be downloaded"*) reason=network ;;
      # A dependency ships a composer plugin that allow-plugins does not permit.
      # Fix by adding it to config.allow-plugins, not by skip-listing the module.
      # Match on the bare term: composer hard-wraps its error box mid-word, so
      # "blocked by your allow-plugins" can arrive as "blocked by yo\nur allow-plugins".
      *allow-plugins*)                                     reason=blocked-plugin ;;
      # An upstream patch (usually vardot/varbase-patches) no longer applies to the
      # current release of the package it targets. Nothing about the module is wrong and
      # nothing local can fix it - the patch set has to catch up with the dependency.
      *"was able to apply patch"*)                         reason=patch-failed ;;
    esac
    printf '%s\tFAILED\t%s\n' "$m" "$reason"
    {
      echo "===== $m ($reason)"
      # Keep the resolver's own explanation. Drop the "Locking …"/"Downloading …"
      # progress lines, which otherwise crowd out the actual error (they did on the
      # first wave-55 run and hid a blocked-plugin failure entirely).
      printf '%s\n' "$err" \
        | grep -E "^\s+- |Problem|Could not find|curl error|blocked by|allow-plugins|apply patch|Fatal|Exception" \
        | grep -vE "^\s+- (Locking|Downloading|Installing|Removing|Upgrading|Downgrading) " \
        | head -10
      echo
    } >> "$FAIL_LOG"
    cp "$SNAP" composer.json    # roll back the poisoned composer.json
  fi
done

trap - INT TERM
rm -f "$SNAP"
# `[ -s ... ] && echo` as the last statement makes a wholly successful run exit 1.
if [ -s "$FAIL_LOG" ]; then echo "failure details: $FAIL_LOG" >&2; fi
exit 0
