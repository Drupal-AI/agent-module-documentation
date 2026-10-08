#!/usr/bin/env bash
# Execution VERIFY (update_helper_checklist H1): PASS when the scratch file is a valid
# updates_checklist.yml: a version section with a '#title', and at least one nested update-hook
# entry that itself has a '#title'. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
f="web/sites/default/update_helper_checklist_file.eval.yml"
# Need at least two '#title' occurrences (one for the version group, one for an update hook)
# and an update-hook key that looks like <something>_update_<N>:
if [ -f "$f" ] \
   && [ "$(grep -c "'#title'" "$f")" -ge 2 ] \
   && grep -Eq "_update_[0-9]+:" "$f"; then
  echo "PASS: $f is an updates_checklist.yml with a version group and an update-hook entry"
  exit 0
fi
echo "FAIL: $f missing or not a valid updates_checklist.yml (need a version '#title', an update-hook key <name>_update_N:, and its '#title')"
exit 1
