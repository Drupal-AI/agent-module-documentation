#!/usr/bin/env bash
# Shared leak-guard logic for the agent-module-documentation repo.
# Security findings are LOCAL-ONLY and must never reach the public GitHub repo.
# This guard blocks two mistakes:
#   (1) staging/committing/pushing a PRIVATE security artifact
#       (a module-root security.md, SECURITY-FINDINGS.md, or scripts/sec-scan/*)
#   (2) adding a NEW public reference to a private finding
#       (a "see security.md" / "SECURITY-FINDINGS" / "local-only" pointer inside a
#        committed doc such as start.md / usage.md / agent/**/*.md)
#
# Legit exception: an agent SOLUTION doc that is itself named security.md and lives
# under an agent/ directory (a module whose subject *is* security) is allowed and
# is git-tracked normally — see .gitignore's `!**/agent/**/security.md`.

# Returns 0 if the path is a PRIVATE security artifact that must never be tracked.
is_private_artifact() {
  local p="$1"
  case "$p" in
    scripts/sec-scan/*) return 0 ;;
  esac
  local base="${p##*/}"
  case "$base" in
    SECURITY-FINDINGS.md|SECURITY-FINDINGS.md.*) return 0 ;;
    security.md)
      # allowed only when it is an agent solution doc (under an agent/ dir)
      case "$p" in
        */agent/*) return 1 ;;   # legit solution doc -> NOT a private artifact
        *) return 0 ;;           # module-root security.md -> private, block
      esac
      ;;
  esac
  return 1
}

# Is this a PUBLIC committed doc we scan for new leak pointers?
is_public_doc() {
  local p="$1"; local base="${p##*/}"
  [ "$base" = "security.md" ] && return 1   # solution doc, skip
  case "$base" in
    usage.md|start.md) return 0 ;;
  esac
  case "$p" in
    */agent/*.md) return 0 ;;
  esac
  return 1
}

# Echo any leak-pointer text found in a single line (empty if none).
line_has_leak_pointer() {
  local line="$1"
  # reference to the aggregate findings file
  if printf '%s' "$line" | grep -qiE 'SECURITY-FINDINGS'; then echo "$line"; return; fi
  # reference to a private security.md that is NOT an agent solution-doc link
  if printf '%s' "$line" | grep -qiE 'security\.md'; then
    if ! printf '%s' "$line" | grep -qiE 'agent/[^)"'"'"' ]*security\.md'; then
      echo "$line"; return
    fi
  fi
  # "local-only" / "local only" security pointer on the same line as "security"
  if printf '%s' "$line" | grep -qiE 'local[[:space:]-]?only' && printf '%s' "$line" | grep -qiE 'securit'; then
    echo "$line"; return
  fi
}
